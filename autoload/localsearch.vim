
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
function! localsearch#Toggle_searchterm(term)
	" Add or remove a:term to/from the current search term
	let l:idx = stridx(@/, a:term)
	if l:idx != -1
		" If a:term is in the search register (@/), we need to delete it (with
		" surrounding '\<' and '\>'.
		" If a:term is the first term in a chain of terms, remove it with a
		" trailling '\|', else remove the leading '\|'
		let l:term = stridx(@/, '\<' . a:term . '\>') != -1 ? '\<' . a:term . '\>' : a:term
		let l:sep1 = stridx(@/, '\|' . l:term       ) != -1 ? '\|' : ''
		let l:sep2 = (stridx(@/,        l:term . '\|') != -1) && (l:idx == 0 || l:idx== 2) ? '\|' : ''
		let l:term = substitute(l:sep1 . l:term . l:sep2, '\\', '\\\\', 'g')
		let @/     = substitute(@/, l:term, '', 'g')
		echom 'Removing ' . l:term . ' to get @/ = ' . @/
	else
		let l:term = g:localsearch_whole_word ? '\<' . a:term . '\>' : a:term
		let l:term = empty(@/) ? l:term : '\|' . l:term
		let @/ = @/ . l:term
		echom 'Adding ' . l:term . ' to get @/ = ' . @/
	endif
	call histdel('search', -1)
	call histadd('search', @/)
endfunction
"}}}

"{{{
function! localsearch#Toggle_searchterm_visual()
	let l:term = localsearch#get_visual_selection()
	" Substitution and literal search logic taken from http://vim.wikia.com/wiki/VimTip171
	if l:term =~? '^[0-9a-z,_]*$' && ( l:term =~? '^[0-9a-z ,_]*$' || !g:localsearch_literal_search )
		if g:localsearch_literal_search
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


