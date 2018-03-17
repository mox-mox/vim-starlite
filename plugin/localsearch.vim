nnoremap <script> <Plug>localsearch_toggle <SID>localsearch_toggle
nnoremap <silent> <SID>localsearch_toggle :call localsearch#Toggle_localsearch()<cr>

nnoremap <script> <Plug>searchterm_toggle <SID>searchterm_toggle
nnoremap <expr> <silent> <SID>searchterm_toggle localsearch#Toggle_searchterm(expand("<cword>"), 1)
