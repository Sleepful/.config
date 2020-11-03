set number
set relativenumber
set whichwrap=b,s,<,>,h,l,[,]
set autoindent
set breakindent
set mouse=a
set scrolloff=24
set cursorline
set ic
set nostartofline
set hlsearch
set incsearch

"shows the last line even if it's incomplete
set display=lastline

"invis char
set list
set showbreak=↪\
"listchar mio
set listchars=tab:▸\ ,extends:→,precedes:←,nbsp:·,trail:·
"listchar para tabs normales
"set listchars=tab:\ \ ,extends:→,precedes:←,nbsp:·,trail:·

"turn off wheel paste
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
filetype plugin on
"set nolisp
syntax on

set foldmethod=syntax
set foldlevelstart=99 "unfold x levels at start (99 unfold everything)

"autocmd FileType hs setlocal expandtab shiftwidth=2 tabstop=2


"To install packages and stuff
"execute pathogen#infect()
"syntax enable
"set background=dark
"colorscheme solarized

"matching parenthesis color
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

"So I can move around in insert
let g:C_Ctrl_j = 'off'
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj
inoremap <C-b> <C-Left>
inoremap <C-g> <C-Right>

"To move up and down in warped lines
nnoremap j gj
nnoremap k gk

"To exit insert mode
imap df <Esc>l


"Autofill enclosures
"imap ( ()<Left>
"imap { {}<Left>
"imap [ []<Left>

"To scroll faster
nnoremap <C-e> 4<C-e>
noremap <C-y> 4<C-y>

"To center the cursor or not
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>


