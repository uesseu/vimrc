"========================================
"# Settings
"========================================
" Lsp settings.
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
" If omni completion is needed, this may be helpful.
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
endfunction

"========================================
"# Python_pip
"========================================
" This section adds command to manage python lsp.
" You can use pip command like below.
"
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
