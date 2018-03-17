
" First some variables that decide the behaviour of the localsearch plugin:

" g:localsearch_literal_search:
" Search selected text literally, without escaping special
" characters. Note: Actual implementation is the other way around, re-enabling
" special characters AFTER disabling them. See :help \V
if !exists('g:localsearch_literal_search')
	let g:localsearch_literal_search = 0
endif

" g:localsearch_whole_word:
" Surround the searchterm with '\<' and '\>' meaning that only whole words
" will match.
" Example: searching 'foo' will match 'foo' and 'foobar', searching '\<foo\>' will only
" match 'foo'
if !exists('g:localsearch_whole_word')
	let g:localsearch_whole_word = v:true
endif


" Public Mappings

" Toggle window-local searching
nnoremap <script> <Plug>localsearch_toggle <SID>localsearch_toggle
nnoremap <silent> <SID>localsearch_toggle :call localsearch#Toggle_localsearch()<cr>

" Add/Remove word under cursor to current search
nnoremap <script> <Plug>searchterm_toggle <SID>searchterm_toggle
nnoremap <silent> <SID>searchterm_toggle :call localsearch#Toggle_searchterm(expand("<cword>"))\|:let v:hlsearch=v:true<CR>"/<CR>

" Add/Remove selected text to current search
vnoremap <script> <Plug>searchterm_toggle_visual <SID>searchterm_toggle_visual
vnoremap <silent> <SID>searchterm_toggle_visual :<C-U>call localsearch#Toggle_searchterm_visual()<CR>\|:let v:hlsearch=v:true<CR>"<C-R>/<CR>

" Toggle g:localsearch_literal_search
nnoremap <silent> <Plug>toggle_localsearch_literal_search :let g:localsearch_literal_search = !g:localsearch_literal_search
			\\| echo "localsearch_literal_search " .  (g:localsearch_literal_search ? "On" : "Off")<CR>

" Toggle g:localsearch_whole_word
nnoremap <silent> <Plug>toggle_localsearch_whole_word :let g:localsearch_whole_word = !g:localsearch_whole_word
			\\| echo "localsearch_whole_word " .  (g:localsearch_whole_word ? "On" : "Off")<CR>
