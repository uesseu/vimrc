"=============================
"# Completion
"=============================
" Set filename completion ignore upper case
set wildignorecase

"=============================
"# Design
"=============================
" Wrap lines
set wrap

" Add indent to wrapped lines
set breakindent

" Show number of line
set number

" Enphasis cursor line
set cursorline

" Make indent automatically
set smartindent

" Use visual bell
set visualbell

" Show paired brace
set showmatch

" Show status line
set laststatus=2

" Use CJK fonts
set ambiwidth=double

" Help language
set helplang=ja,en

"=============================
"# Search
"=============================
" Search imediately
set incsearch

" Wrap search
set wrapscan

" Hilight found wordk
set hlsearch

"=============================
"# Encoding
"=============================
set encoding=UTF-8

"=============================
"# Term_command_compatibility
"=============================
if has('nvim')
  command! -nargs=* Term split | terminal <args>
endif

"=============================
"# Python
"=============================
autocmd FileType python set shiftwidth=4
colorscheme slate
