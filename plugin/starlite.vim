" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("g:loaded_starlite") || &cp
  finish
endif
let g:loaded_starlite   = 001
let s:keepcpo           = &cpo
set cpo&vim




" Variables that control the plugin behaviour ----------------------------------


" g:starlite_replace_history:
" When appending or removing a search term to the search, replace the last
" line in search history with the updated search string
if !exists('g:starlite_replace_history')
	let g:starlite_replace_history = v:true
endif

" g:starlite_jump:
" Jump to next result after starting a search like the default word search '*'
" does
if !exists('g:starlite_jump')
	let g:starlite_jump = v:true
endif


" Public Mappings --------------------------------------------------------------

" Clear last search
nnoremap <script> <Plug>starlite_clear_searchterm :silent let @/= ""<CR>


" Add/Remove word under cursor to current search
nnoremap <script> <Plug>starlite_fwd <SID>starlite_fwd
nnoremap <silent> <SID>starlite_fwd :execute starlite#Toggle_searchterm(expand("<cword>"), v:false, 1)<CR>

nnoremap <script> <Plug>starlite_bwd <SID>starlite_bwd
nnoremap <silent> <SID>starlite_bwd :execute starlite#Toggle_searchterm(expand("<cword>"), v:false, 0)<CR>

nnoremap <script> <Plug>starlite_fwd_whole <SID>starlite_fwd_whole
nnoremap <silent> <SID>starlite_fwd_whole :execute starlite#Toggle_searchterm(expand("<cword>"), v:true, 1)<CR>

nnoremap <script> <Plug>starlite_bwd_whole <SID>starlite_bwd_whole
nnoremap <silent> <SID>starlite_bwd_whole :execute starlite#Toggle_searchterm(expand("<cword>"), v:true, 0)<CR>


" Add/Remove selected text to current search
vnoremap <script> <Plug>starlite_fwd_visual <SID>starlite_fwd_visual
vnoremap <silent> <SID>starlite_fwd_visual :<C-U>execute starlite#Toggle_searchterm_visual(v:false, 1)<CR>

vnoremap <script> <Plug>starlite_bwd_visual <SID>starlite_bwd_visual
vnoremap <silent> <SID>starlite_bwd_visual :<C-U>execute starlite#Toggle_searchterm_visual(v:false, 0)<CR>

vnoremap <script> <Plug>starlite_fwd_exact_visual <SID>starlite_fwd_exact_visual
vnoremap <silent> <SID>starlite_fwd_exact_visual :<C-U>execute starlite#Toggle_searchterm_visual(v:true, 1)<CR>

vnoremap <script> <Plug>starlite_bwd_exact_visual <SID>starlite_bwd_exact_visual
vnoremap <silent> <SID>starlite_bwd_exact_visual :<C-U>execute starlite#Toggle_searchterm_visual(v:true, 0)<CR>


" Toggle g:starlite_replace_history
nnoremap <silent> <Plug>starlite_toggle_replace_history :let g:starlite_replace_history = !g:starlite_replace_history
			\\| echo "starlite_replace_history " .  (g:starlite_replace_history ? "On" : "Off")<CR>

" Toggle g:starlite_jump
nnoremap <silent> <Plug>starlite_toggle_jump :let g:starlite_jump = !g:starlite_jump
			\\| echo "starlite_jump " .  (g:starlite_jump ? "On" : "Off")<CR>



let &cpo= s:keepcpo
unlet s:keepcpo
