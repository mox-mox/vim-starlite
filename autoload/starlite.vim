" Public Functions -------------------------------------------------------------

"{{{
function! starlite#Search(visual_mode, search_forward, exact, replace)

	" Get the word under the cursor or visual selection
	let l:term = a:visual_mode ? starlite#get_visual_searchterm(a:exact) : expand("<cword>")
	let l:whole_word = a:exact && !a:visual_mode
	let l:searchterm = l:whole_word ? '\<' . l:term . '\>' : l:term

	" Not starting a new search, check if we should add or remove l:term from
	" the search
	if !a:replace
		let l:searchterms = split(@/, '\\|')
		let l:index = match(l:searchterms, l:term)

		if l:index != -1 " l:term is part of l:searchterms -> remove it
			let l:removed_term = remove(l:searchterms, l:index)
			"echom 'Removing ' . l:removed_term . ' from the search'
		else " l:term is a new term -> add it
			:call add(l:searchterms, l:searchterm)
			"echom 'Adding ' . l:term . ' to the search'
		endif

		let l:searchterm = join(l:searchterms, '\|')
	endif

	let @/ = l:searchterm

	" Replace/update history when adding/subtracting to the search, but always
	" add an entry when starting a new search
	if g:starlite_replace_history && !a:replace
		call histdel('search', -1)
	endif
	call histadd('search', @/)

	" This function needs to be executed to get around *function-search-undo*
	return ':let v:hlsearch=1|' . (g:starlite_jump ? ['?','/'][a:search_forward] : ':let v:searchforward='. ['0','1'][a:search_forward])
endfunction
"}}}

"{{{
function! starlite#toggle_replace_history()
	let g:starlite_replace_history = !g:starlite_replace_history
	echo "starlite_replace_history " .  (g:starlite_replace_history ? "On" : "Off")
endfunction
"}}}

"{{{
function! starlite#toggle_jump()
	let g:starlite_jump = !g:starlite_jump
	echo "starlite_jump " .  (g:starlite_jump ? "On" : "Off")
endfunction
"}}}


" Private Functions ------------------------------------------------------------

"{{{
function! starlite#get_visual_selection() range
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

"{{{
function! starlite#get_visual_searchterm(literal)
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
	return l:term
endfunction
"}}}

