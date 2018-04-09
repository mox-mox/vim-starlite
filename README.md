Starlite - Search for a Word Under Vims Cursor
==============================================

What does it do?
----------------
Add the word under the cursor to the current search at the press of a key. Also works for visual selection.

I've already got `*`, what's new here?
--------------------------------------
When you press `*` on a word (that is with the cursor over that word), vim will
search for that word.  To do so, it will *replace* the current search word.
With this plugin, the word gets *added* to the search word. That means vim will
now search for all occurences of the previous and the newly added word. You can
press `*` on the word again and it will be removed from the search.



Wait, what? Why?
----------------
Imagine you want to trace a variable trough a codebase:
 * You start in *file 1* and search for all occurences of *variable A*
 * *Variable A* is assigned to *variable B* and *variable C* so you need to trace those as well.
 * With **Starlite** you just press ` * ` on *B* and *C* and search for these,
   too. They will not replace the old search word, so now you are searching for
   all three words (*A*, *B*, *C*)
 * FANCY


How do I use it?
----------------
1. Install it using your favorite plugin manager, e.g. `Plug 'mox-mox/vim-starlite'` for vim-plug.
2. Copy the mappings in :help starlite-recommended into your .vimrc/init.vim
3. Continue using Vim the way you did. But search for multiple words with one key press ;)


