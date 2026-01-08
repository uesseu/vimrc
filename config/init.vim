"######################################################################
"# Vimrc or init.vim
"#=====================================================================
"# Every files with '.vim' extension in this directory will be loaded.
"# This is my substitute of vimrc. For someone, it is just a example.
"######################################################################

"=============================
"# Commandline
"=============================
set timeoutlen=1000
set mouse=

"=============================
"# Design
"=============================
set number
set cursorline
set smartindent
set visualbell
set showmatch
set ambiwidth=double

set bg=dark
au VimEnter * ++once colorscheme retrobox
"=============================
"# Search
"=============================
set incsearch
set wrapscan
set hlsearch

"=============================
"# Encoding
"=============================
set encoding=UTF-8

"=============================
"# Tab and shift
"=============================
set shiftwidth=2
set tabstop=4
set expandtab
