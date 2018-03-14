"{{{
function Set_localsearch()
	let g:last_search = @/
	let @/ = get(w:, 'last_search', '')
endfunction
"}}}

"{{{
function Unset_localsearch()
	let w:last_search = @/
	let @/ = get(g:, 'last_search', '')
endfunction
"}}}

"{{{
function Enable_localsearch()
	augroup localsearch
		autocmd!
		autocmd WinEnter * :call Set_localsearch()
		autocmd WinLeave * :call Unset_localsearch()
		"autocmd WinEnter * :execute 'silent !notify-send "WinEnter"'
		"autocmd WinLeave * :execute 'silent !notify-send "WinLeave"'
	augroup END
	:call Set_localsearch()
endfunction
"}}}

"{{{
function Disable_localsearch()
	:call Unset_localsearch()
	augroup localsearch
		autocmd!
	augroup END
endfunction
"}}}

"{{{
function Toggle_localsearch()
	if exists('#localsearch#WinEnter')
		:call Disable_localsearch()
	else
		:call Enable_localsearch()
	endif
endfunction
"}}}

"nnoremap  :call Toggle_localsearch()<CR>
