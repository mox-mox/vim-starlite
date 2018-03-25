" Public Functions -------------------------------------------------------------

"{{{
function! starlite#Toggle_searchterm(term, whole_word, direction)
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

	if g:starlite_replace_history
		call histdel('search', -1)
	endif
	call histadd('search', @/)
	return ':let v:hlsearch=1|' . (g:starlite_jump ? ['?','/'][a:direction] : ':let v:searchforward='.a:direction)
endfunction
"}}}

"{{{
function! starlite#Toggle_searchterm_visual(literal, direction)
	let l:term = starlite#get_visual_selection()
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
	return starlite#Toggle_searchterm(l:term, v:false, a:direction)
endfunction
"}}}


" Private Functions ------------------------------------------------------------

"{{{
function! starlite#get_visual_selection()
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
