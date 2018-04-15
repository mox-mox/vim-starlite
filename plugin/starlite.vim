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
" Jump to next result after starting a search, like the default word search '*'
" does
if !exists('g:starlite_jump')
	let g:starlite_jump = v:true
endif


" Public Mappings --------------------------------------------------------------

" Clear last search
nnoremap <script> <Plug>starlite_clear_searchterm :silent let @/= ""<CR>
vnoremap <script> <Plug>starlite_clear_searchterm :silent let @/= ""<CR>


"                                                                        visual   forward  exact     replace
nnoremap <script> <Plug>starlite_fwd_x_add :     execute starlite#Search(v:false, v:true,  v:true,   v:false)<CR>
nnoremap <script> <Plug>starlite_fwd_i_add :     execute starlite#Search(v:false, v:true,  v:false,  v:false)<CR>
nnoremap <script> <Plug>starlite_bwd_x_add :     execute starlite#Search(v:false, v:false, v:true,   v:false)<CR>
nnoremap <script> <Plug>starlite_bwd_i_add :     execute starlite#Search(v:false, v:false, v:false,  v:false)<CR>

nnoremap <script> <Plug>starlite_fwd_x_rpl :     execute starlite#Search(v:false, v:true,  v:true,   v:true )<CR>
nnoremap <script> <Plug>starlite_fwd_i_rpl :     execute starlite#Search(v:false, v:true,  v:false,  v:true )<CR>
nnoremap <script> <Plug>starlite_bwd_x_rpl :     execute starlite#Search(v:false, v:false, v:true,   v:true )<CR>
nnoremap <script> <Plug>starlite_bwd_i_rpl :     execute starlite#Search(v:false, v:false, v:false,  v:true )<CR>

vnoremap <script> <Plug>starlite_fwd_x_add :<C-U>execute starlite#Search(v:true,  v:true,  v:true,   v:false)<CR>
vnoremap <script> <Plug>starlite_fwd_i_add :<C-U>execute starlite#Search(v:true,  v:true,  v:false,  v:false)<CR>
vnoremap <script> <Plug>starlite_bwd_x_add :<C-U>execute starlite#Search(v:true,  v:false, v:true,   v:false)<CR>
vnoremap <script> <Plug>starlite_bwd_i_add :<C-U>execute starlite#Search(v:true,  v:false, v:false,  v:false)<CR>

vnoremap <script> <Plug>starlite_fwd_x_rpl :<C-U>execute starlite#Search(v:true,  v:true,  v:true,   v:true )<CR>
vnoremap <script> <Plug>starlite_fwd_i_rpl :<C-U>execute starlite#Search(v:true,  v:true,  v:false,  v:true )<CR>
vnoremap <script> <Plug>starlite_bwd_x_rpl :<C-U>execute starlite#Search(v:true,  v:false, v:true,   v:true )<CR>
vnoremap <script> <Plug>starlite_bwd_i_rpl :<C-U>execute starlite#Search(v:true,  v:false, v:false,  v:true )<CR>

" Toggle g:starlite_replace_history
command StarliteToggleReplaceHistory :call starlite#toggle_replace_history()
nnoremap <silent> <Plug>starlite_toggle_replace_history :StarliteToggleReplaceHistory<CR>

" Toggle g:starlite_jump
command StarliteToggleJump :call starlite#toggle_jump()
nnoremap <silent> <Plug>starlite_toggle_jump :StarliteToggleJump<CR>

let &cpo= s:keepcpo
unlet s:keepcpo
