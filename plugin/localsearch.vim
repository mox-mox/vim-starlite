
" First some variables that decide the behaviour of the localsearch plugin:


" g:localsearch_replace_history:
" When appending or removing a search term to the search, replace the last
" line in search history with the updated search string
if !exists('g:localsearch_replace_history')
	let g:localsearch_replace_history = v:true
endif

" g:localsearch_jump:
" Jump to next result after starting a search like the default word search '*'
" does
if !exists('g:localsearch_jump')
	let g:localsearch_jump = v:true
endif

function! g:Fwd()
	return ':let v:hlsearch=1|' . (g:localsearch_jump ? '/' : ':let v:searchforward=1')
endfunction

function! g:Bwd()
	return ':let v:hlsearch=1|' . (g:localsearch_jump ? '?' : ':let v:searchforward=0')
endfunction

" Public Mappings

" Toggle window-local searching
nnoremap <script> <Plug>toggle_localsearch <SID>toggle_localsearch
nnoremap <silent> <SID>toggle_localsearch :call localsearch#Toggle_localsearch()<cr>

" Clear last search
nnoremap <script> <Plug>clear_searchterm :silent let @/= ""<CR>




" Add/Remove word under cursor to current search
nnoremap <script> <Plug>add_searchterm_fwd <SID>add_searchterm_fwd
nnoremap <silent> <SID>add_searchterm_fwd :call localsearch#Toggle_searchterm(expand("<cword>"), v:false)\|:execute g:Fwd()<CR>

nnoremap <script> <Plug>add_searchterm_bwd <SID>add_searchterm_bwd
nnoremap <silent> <SID>add_searchterm_bwd :call localsearch#Toggle_searchterm(expand("<cword>"), v:false)\|:execute g:Bwd()<CR>

nnoremap <script> <Plug>add_searchterm_fwd_whole <SID>add_searchterm_fwd_whole
nnoremap <silent> <SID>add_searchterm_fwd_whole :call localsearch#Toggle_searchterm(expand("<cword>"), v:true)\|:execute g:Fwd()<CR>

nnoremap <script> <Plug>add_searchterm_bwd_whole <SID>add_searchterm_bwd_whole
nnoremap <silent> <SID>add_searchterm_bwd_whole :call localsearch#Toggle_searchterm(expand("<cword>"), v:true)\|:execute g:Bwd()<CR>


" Add/Remove selected text to current search
vnoremap <script> <Plug>add_searchterm_fwd_visual <SID>add_searchterm_fwd_visual
vnoremap <silent> <SID>add_searchterm_fwd_visual :<C-U>call localsearch#Toggle_searchterm_visual(v:false)<CR>\|:execute g:Fwd()<CR>

vnoremap <script> <Plug>add_searchterm_bwd_visual <SID>add_searchterm_bwd_visual
vnoremap <silent> <SID>add_searchterm_bwd_visual :<C-U>call localsearch#Toggle_searchterm_visual(v:false)<CR>\|:execute g:Bwd()<CR>

vnoremap <script> <Plug>add_searchterm_fwd_exact_visual <SID>add_searchterm_fwd_exact_visual
vnoremap <silent> <SID>add_searchterm_fwd_exact_visual :<C-U>call localsearch#Toggle_searchterm_visual(v:true)<CR>\|:execute g:Fwd()<CR>

vnoremap <script> <Plug>add_searchterm_bwd_exact_visual <SID>add_searchterm_bwd_exact_visual
vnoremap <silent> <SID>add_searchterm_bwd_exact_visual :<C-U>call localsearch#Toggle_searchterm_visual(v:true)<CR>\|:execute g:Bwd()<CR>





" Toggle g:localsearch_replace_history
nnoremap <silent> <Plug>toggle_localsearch_replace_history :let g:localsearch_replace_history = !g:localsearch_replace_history
			\\| echo "localsearch_replace_history " .  (g:localsearch_replace_history ? "On" : "Off")<CR>

" Toggle g:localsearch_jump
nnoremap <silent> <Plug>toggle_localsearch_jump :let g:localsearch_jump = !g:localsearch_jump
			\\| echo "localsearch_jump " .  (g:localsearch_jump ? "On" : "Off")<CR>
