"========================================
"# About_this
"========================================
" Setting file of plugins.

"=============================
"# ddc
"=============================
" Plugins__Complete:
" Plugin to complete asynchoronously.

function! s:start_ddc()
  call ddc#custom#patch_global('ui', 'native')
  call ddc#custom#patch_global('sourceParams', #{around: #{ maxSize: 500 },})
  call ddc#custom#patch_global('sources', ['vim-lsp', 'around'])
  call ddc#custom#patch_global('sourceOptions', #{
        \   _: #{
        \     matchers: ['matcher_fuzzy'],
        \     sorters: ['sorter_fuzzy'],
        \     converters: ['converter_fuzzy']
        \   },
	\   around: #{ mark: 'Around' },
	\   vim-lsp: #{
	\     mark: 'LSP',
	\     forceCompletionPattern: '\w+|\.\w*|:\w*|->\w*' },
\ })
  call ddc#enable()
endfunction

if v:vim_did_enter
  call s:start_ddc()
else
  au VimEnter * call s:start_ddc()
endif


"========================================
"# vim_lsp_settings
"========================================
" Plugins__LSP:
" Plugin which configures LSP automatically.

let g:markdown_fenced_languages = ['ts=typescript']
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server', 'deno']
let g:lsp_diagnostics_float_insert_mode_enabled = 1

"========================================
"# vim_lsp
"========================================
" Plugins__LSP:
" LSP plugin of vim and neovim.

let g:lsp_diagnostics_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_inlay_hints_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_text_edit_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_float_delay = 100
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_echo_cursor = 0
noremap <buffer> <expr><c-j> lsp#scroll(+1)
noremap <buffer> <expr><c-k> lsp#scroll(-1)
autocmd FileType * nmap K <plug>(lsp-hover-float)

"========================================
"# Omnifunc
"========================================
" Plugins__LSP:
" Plugin_settings__vim_lsp:
" Plugin_settings__vim_lsp_settings:
" If omni completion is needed, this may be helpful.

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
endfunction

"========================================
"# Python_pip
"========================================
" Plugins__LSP:
" This section adds command to manage python lsp.
" You can use pip command like below.

" LspPip install numpy
"
function! s:lsp_python_pip(module)
  echo 'Installing '.a:module
  let loc = g:lsp_settings#global_settings_dir().'/servers/'
  let command = '/venv/bin/pip'
  let names = ['pyls-all', 'pyls', 'pylsp-all']
  for name in names
    let code = loc.name.command
    echo '> '.code
    echo system(code)
  endfor
  echo 'Ended'
endfunction

command! -nargs=1 LspPip call s:lsp_python_pip("<args>")
