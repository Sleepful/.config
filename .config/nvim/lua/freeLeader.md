leader keys free?:

- ; - localleader, taken for filetype-based plugins like paredit
- , - could b quick hotkeys
- \
- ? - could replace this, perhaps "navigation leader"

use for local leaders? or for custom keys?
need better one for buffer operations... <space>b is taken for bookmarks

These are up for grabs:

- m (could be for jumping to marks, as I overwrote \` key, but `m` still leaves marks)

Taken:

- t (could be for teles bc `s` is too loaded): used for forward-word
- <C-n>     for LSP stuff

# <F2>
used for custom binds, should move em elsewhere 

# <leader>
mappings for `<leader>`

- b for buffer
- a for surround ("Around")
- e for bookmarks ("Entries")
- h for harpoon
- y yank
- t tabs (needs work)
- l quickfix Lists
- k telekasten (should be local leader)
- u UI

## quickies with <leader>
- q quit
- Q quit!
- w Write File
- o Open Diagnostics
- . grep
- < grep files current
  * can turn into find files by going to directory searh and then turning to find files
    + C-d -> C-f
    + or to go back into grep
    + C-d -> C-e
- <space> find files root

## Other mappings that are meh
- , switch buffer with ugly telescope search 
- s Search
- : command history
- c code (actually markdown preview and... calendar?)
- / fuzzy current buffer
- ? recently opened files
- g git (what? it just file searches)
- p (for psql mode, should be on local leader...)
- S list all marks, what?
- 

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
