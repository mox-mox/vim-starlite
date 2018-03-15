" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("g:loaded_Localsearch") || &cp
  finish
endif
let g:loaded_Localsearch= 0.0.1
let s:keepcpo           = &cpo
set cpo&vim

" Public Interface:


"{{{
function! Toggle_localsearch()
	if exists('#localsearch#WinEnter')
		:call s:Disable_localsearch()
	else
		:call s:Enable_localsearch()
	endif
endfunction
"}}}




"nnoremap  :call Toggle_localsearch()<CR>

" Private functions ------------------------------------------------------------

"{{{
function! s:Enable_localsearch()
	augroup localsearch
		autocmd!
		autocmd WinEnter * :call s:Set_localsearch()
		autocmd WinLeave * :call s:Unset_localsearch()
		"autocmd WinEnter * :execute 'silent !notify-send "WinEnter"'
		"autocmd WinLeave * :execute 'silent !notify-send "WinLeave"'
	augroup END
	:call s:Set_localsearch()
endfunction
"}}}

"{{{
function! s:Disable_localsearch()
	:call s:Unset_localsearch()
	augroup localsearch
		autocmd!
	augroup END
endfunction
"}}}

"{{{
function! s:Set_localsearch()
	let g:last_search = @/
	let @/ = get(w:, 'last_search', '')
endfunction
"}}}

"{{{
function! s:Unset_localsearch()
	let w:last_search = @/
	let @/ = get(g:, 'last_search', '')
endfunction
"}}}

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo




















