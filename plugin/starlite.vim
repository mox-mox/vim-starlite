
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

" Toggle window-local searching
nnoremap <script> <Plug>toggle_localsearch <SID>toggle_localsearch
nnoremap <silent> <SID>toggle_localsearch :call starlite#Toggle_localsearch()<cr>

" Clear last search
nnoremap <script> <Plug>clear_searchterm :silent let @/= ""<CR>


" Add/Remove word under cursor to current search
nnoremap <script> <Plug>starlite_toggleterm_fwd <SID>starlite_toggleterm_fwd
nnoremap <silent> <SID>starlite_toggleterm_fwd :execute starlite#Toggle_searchterm(expand("<cword>"), v:false, 1)<CR>

nnoremap <script> <Plug>starlite_toggleterm_bwd <SID>starlite_toggleterm_bwd
nnoremap <silent> <SID>starlite_toggleterm_bwd :execute starlite#Toggle_searchterm(expand("<cword>"), v:false, 0)<CR>

nnoremap <script> <Plug>starlite_toggleterm_fwd_whole <SID>starlite_toggleterm_fwd_whole
nnoremap <silent> <SID>starlite_toggleterm_fwd_whole :execute starlite#Toggle_searchterm(expand("<cword>"), v:true, 1)<CR>

nnoremap <script> <Plug>starlite_toggleterm_bwd_whole <SID>starlite_toggleterm_bwd_whole
nnoremap <silent> <SID>starlite_toggleterm_bwd_whole :execute starlite#Toggle_searchterm(expand("<cword>"), v:true, 0)<CR>


" Add/Remove selected text to current search
vnoremap <script> <Plug>starlite_toggleterm_fwd_visual <SID>starlite_toggleterm_fwd_visual
vnoremap <silent> <SID>starlite_toggleterm_fwd_visual :<C-U>execute starlite#Toggle_searchterm_visual(v:false, 1)<CR>

vnoremap <script> <Plug>starlite_toggleterm_bwd_visual <SID>starlite_toggleterm_bwd_visual
vnoremap <silent> <SID>starlite_toggleterm_bwd_visual :<C-U>execute starlite#Toggle_searchterm_visual(v:false, 0)<CR>

vnoremap <script> <Plug>starlite_toggleterm_fwd_exact_visual <SID>starlite_toggleterm_fwd_exact_visual
vnoremap <silent> <SID>starlite_toggleterm_fwd_exact_visual :<C-U>execute starlite#Toggle_searchterm_visual(v:true, 1)<CR>

vnoremap <script> <Plug>starlite_toggleterm_bwd_exact_visual <SID>starlite_toggleterm_bwd_exact_visual
vnoremap <silent> <SID>starlite_toggleterm_bwd_exact_visual :<C-U>execute starlite#Toggle_searchterm_visual(v:true, 0)<CR>


" Toggle g:starlite_replace_history
nnoremap <silent> <Plug>starlite_toggle_replace_history :let g:starlite_replace_history = !g:starlite_replace_history
			\\| echo "starlite_replace_history " .  (g:starlite_replace_history ? "On" : "Off")<CR>

" Toggle g:starlite_jump
nnoremap <silent> <Plug>starlite_toggle_jump :let g:starlite_jump = !g:starlite_jump
			\\| echo "starlite_jump " .  (g:starlite_jump ? "On" : "Off")<CR>
