A VIM/NeoVIM Plugin for Window-Local Searching
==============================================

Wait, what? Why?
----------------
Imagine you are looking at some big codebase and you want to do some refactoring.
 - You start in file 1 and search for all occurences of variable A
 - Variable A is fed into function F in file 2 as variable B
 - You open file 2 in a new tab|split and want to trace variable B there
 - When you go back and forth between the two vim-windows|files you'll always have to switch between searching for variable A and B
 - ENTER LOCALSEARCH

So what does it do?
-------------------
Localsearch sets independent search terms for different windows when the localsearch mode is enabled. All the magic happens by setting the last search term register on window entry, and the normal search commands continue working.

How do I use it?
----------------
1. Install it using your favorite plugin manager, e.g. plug 'mox-mox/vim-localsearch' for vim-plug.
2. call Enable_localsearch() to enable and Disable_localsearch() to disable the local search mode.
3. Map the Toggle_localsearch() function to some key to facilitate usage. For example, using <C-/>:
	nnoremap  :call Toggle_localsearch()<CR>
4. Profit


