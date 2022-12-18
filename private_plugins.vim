let s:at_start = {'lazy': 1, 'on_event': 'VimEnter'}
"========================================
"# Git
"========================================

" Git diff inside vim
call dein#add('airblade/vim-gitgutter', s:at_start)

"========================================
"# Markdown
"========================================

" Markdown
call dein#add('nelstrom/vim-markdown-folding', {'lazy': 1, 'on_ft': 'markdown'})

" TableMode
call dein#add('dhruvasagar/vim-table-mode', s:at_start)

"========================================
"# UI
"========================================

" Dein UI like vimplug
call dein#add('wsdjeg/dein-ui.vim', s:at_start)

" Manage sidebar of vim
call dein#add('brglng/vim-sidebar-manager', s:at_start)

"========================================
"# Design
"========================================

" Tagbar
call dein#add('majutsushi/tagbar', s:at_start)

" Airline
call dein#add('itchyny/lightline.vim', s:at_start)

" Theme
call dein#add('tomasr/molokai', s:at_start)

" Illuminate selected word
call dein#add('RRethy/vim-illuminate', s:at_start)

" Visual mark
call dein#add('kshenoy/vim-signature', s:at_start)

" Tree-sitter
if has('nvim')
  call dein#add('nvim-treesitter/nvim-treesitter', s:at_start)
endif

"========================================
"# Denite
"========================================

" Denite
call dein#add('Shougo/denite.nvim', s:at_start)

" Denite emoji
call dein#add('junegunn/vim-emoji', s:at_start)
call dein#add('pocari/vim-denite-emoji', s:at_start)

" Mark directories
call dein#add('kmnk/denite-dirmark', s:at_start)

" Git command for denite
call dein#add('neoclide/denite-git', s:at_start)

"========================================
"# Python
"========================================

" Autopep8
call dein#add('tell-k/vim-autopep8', {'lazy': 1, 'on_ft': 'python'})

" Adjust indent
call dein#add('Vimjas/vim-python-pep8-indent', {'lazy': 1, 'on_ft': 'python'})

"========================================
"# Utility
"========================================

" Undotree
call dein#add('mbbill/undotree', s:at_start)

" Filer
call dein#add('lambdalisue/fern.vim', {'rev': 'main', 'lazy': 1, 'on_event': 'VimEnter'})

" Japanese documentation of vim
call dein#add('vim-jp/vimdoc-ja', {'lazy': 1, 'on_cmd': 'help'})
