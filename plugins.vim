let s:at_start = {'lazy': 1, 'on_event': 'VimEnter'}


"========================================
"# Needed
"========================================
"These are needed for plugin manager

if !has('nvim')
  call dein#add('roxma/nvim-yarp', s:at_start)
  call dein#add('roxma/vim-hug-neovim-rpc', s:at_start)
endif

"========================================
"# LSP
"========================================

" Connector of LSP
call dein#add('prabirshrestha/vim-lsp', s:at_start)

" Make settings of LSP automatically
call dein#add('mattn/vim-lsp-settings', s:at_start)

"========================================
"# Complete
"========================================

" Deno based plugin needs this
call dein#add('vim-denops/denops.vim', s:at_start)
let s:on_denops = {'lazy': 1, 'on_source': ['denops.vim']}

" Complete automatically
call dein#add('Shougo/ddc.vim', s:on_denops)

" Use ddc in commandline
" call dein#add('Shougo/pum.vim')

" Required by ddc
call dein#add('Shougo/ddc-ui-native', s:on_denops)

" Complete by words around the cursor
call dein#add('Shougo/ddc-source-around', s:on_denops)

" Complete automatically by LSP by neovim interface
" call dein#add('Shougo/ddc-source-nvim-lsp')

" Complete automatically by LSP by vim-lsp interface
call dein#add('shun/ddc-vim-lsp', s:on_denops)

" Complete automatically by file name
call dein#add('LumaKernel/ddc-file', s:on_denops)

" Filter completed words by matching head
" call dein#add('Shougo/ddc-matcher_head')

" Sort completed words
" call dein#add('Shougo/ddc-sorter_rank')

" Remove overlap of completed words
call dein#add('Shougo/ddc-converter_remove_overlap', s:on_denops)

" Filter and sort completed words fuzzy
call dein#add('tani/ddc-fuzzy', s:on_denops)

