leader keys free?:

- ; - localleader
- , - could b quick hotkeys
- \
- ? - could replace this, perhaps "navigation leader"

use for local leaders? or for custom keys?
need better one for buffer operations... <space>b is taken for bookmarks

<space> leader:

...

This are up for grabs:

- m (could be for jumping to marks, as I overwrote \` key, but `m` still leaves marks)

Taken:

- t (could be for teles bc `s` is too loaded): used for forward-word
- <C-n>     for LSP stuff
- <leader>b for buffer
- <leader>a for surround
- <leader>e for bookmarks

additionally:

<f2> in insert mode is free, right now it opens some stuff that could be moved to tele
<F2> in normal mode is,,, ok?

nav: 

- <Home> <End>for bookmarks
- <S-PageUp><S-PageDown> for quiqkfix
- need one for diagnostics? could be <S-Home> <S-End>

telescope:

- <c-s> hop to result
- <c-q> send to quickfix list

other:

- allow oil.nvim to exit with esc key
