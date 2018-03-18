" Public Functions -------------------------------------------------------------

"{{{
function! localsearch#Toggle_localsearch()
	" Turn local search mode on or off
	if exists('#localsearch#WinEnter')
		:call localsearch#Disable_localsearch()
	else
		:call localsearch#Enable_localsearch()
	endif
endfunction
"}}}

"{{{
function! localsearch#Toggle_searchterm(term, whole_word)
	""" Add or remove a:term to/from the current search term """
	let l:searchterms = split(@/, '\\|')
	let l:index = match(l:searchterms, a:term)
	if l:index != -1 " a:term is part of s:searchterms -> remove it
		let l:removed_term = remove(l:searchterms, l:index)
		echom 'Removing ' . l:removed_term

	else " a:term is a new term -> add it
		let l:term = a:whole_word ? '\<' . a:term . '\>' : a:term
		:call add(l:searchterms, l:term)
		echom 'Adding ' . l:term
	endif

	let l:new_searchterms = join(l:searchterms, '\|')
	let @/ = l:new_searchterms

	if g:localsearch_replace_history
		call histdel('search', -1)
	endif
	call histadd('search', @/)
endfunction
"}}}

"{{{
function! localsearch#Toggle_searchterm_visual(literal)
	let l:term = localsearch#get_visual_selection()
	" Substitution and literal search logic taken from http://vim.wikia.com/wiki/VimTip171
	if l:term !~? '^[0-9a-z,_]*$' && ( l:term !~? '^[0-9a-z ,_]*$' || !a:literal )
		if a:literal
			let l:term = substitute(l:term, '\n', '\\n', 'g')
		else
			let l:term = substitute(l:term, '^\_s\+', '\\s\\+', '')
			let l:term = substitute(l:term, '\_s\+$', '\\s\\*', '')
			let l:term = substitute(l:term, '\_s\+', '\\_s\\+', 'g')
		endif
		let l:term = '\V'. l:term
	endif
	:call localsearch#Toggle_searchterm(l:term, v:false)
endfunction
"}}}


" Private Functions ------------------------------------------------------------

"{{{ Local Search

"{{{
function! localsearch#Enable_localsearch()
	augroup localsearch
		autocmd!
		autocmd WinEnter * :call localsearch#Set_localsearch()
		autocmd WinLeave * :call localsearch#Unset_localsearch()
		"autocmd WinEnter * :execute 'silent !notify-send "WinEnter"'
		"autocmd WinLeave * :execute 'silent !notify-send "WinLeave"'
	augroup END
	:call localsearch#Set_localsearch()
endfunction
"}}}

"{{{
function! localsearch#Disable_localsearch()
	:call localsearch#Unset_localsearch()
	augroup localsearch
		autocmd!
	augroup END
endfunction
"}}}

"{{{
function! localsearch#Set_localsearch()
	let g:last_search = @/
	let @/ = get(w:, 'last_search', '')
endfunction
"}}}

"{{{
function! localsearch#Unset_localsearch()
	let w:last_search = @/
	let @/ = get(g:, 'last_search', '')
endfunction
"}}}

"}}}

"{{{
function! localsearch#get_visual_selection()
	" Source: xolox: https://stackoverflow.com/a/6271254/4360539
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
"}}}

"
""{{{
"function! localsearch#list_find(list, term)
"	""" Find the index and sub-index of term in list """
"	" Example: list_find(['abc', 'def', 'ghi'], 'ef') returns [1, 1]
"
"	"echom 'localsearch#list_search( ' . a:list . ', ' . a:term . ' )'
"	let l:index    = 0
"	let l:subindex = 0
"	while l:index < len(a:list)
"		let l:subindex = stridx(a:list[l:index], a:term)
"		if l:subindex != -1
"			return [l:index, l:subindex]
"		endif
"		let l:index = l:index + 1
"	endwhile
"
"	return [-1, -1]
"endfunction
""}}}
"
