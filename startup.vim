"########################################
"# Start up script for denops and dpp.
"########################################

set nocompatible

" Dpp base path.
const s:dpp_base = expand('<script>:p:h').'/'
" Dpp repositry path.
const s:dpp_github = s:dpp_base . 'repos/github.com/'
" Dpp configure script path.
const s:ts_config = s:dpp_base.'config.ts'
" Denops shared server ip.
const g:denops_server_addr = '127.0.0.1:32123'

" Base repositryes of dpp.
" These are on github.
const s:base_repos = [
      \'vim-denops/denops-shared-server.vim',
      \'vim-denops/denops.vim',
      \'Shougo/dpp.vim',
      \'Shougo/dpp-ext-installer',
      \'Shougo/dpp-protocol-git',
      \'Shougo/dpp-ext-toml',
      \'Shougo/dpp-ext-lazy',
      \'Shougo/dpp-ext-local'
      \]

"########################################
"# Script to load denops and dpp.
"########################################

" Install dpp if it is not installed.
if isdirectory(s:dpp_base . 'installer/done') == 0
  exec "source ".s:dpp_base.'installer/install.vim'
endif

set noloadplugins
au VimEnter * runtime! plugin/**/*.vim


" Set runtimepath and start core plugins.
for repo in s:base_repos
  execute 'set runtimepath^=' .. s:dpp_github . repo
endfor

" Load startup scripts of dpp state.
if s:dpp_base->dpp#min#load_state()
  echo 'Installing plugins'
  autocmd User DenopsReady
  \ : echohl WarningMsg
  \ | echomsg 'Installing plugins.'
  \ | echohl NONE
  \ | call dpp#async_ext_action('installer', 'install')
  call dpp#make_state(s:dpp_base, s:ts_config)
endif

" After making state.
autocmd User Dpp:makeStatePost
  \ : echohl WarningMsg
  \ | echomsg 'dpp make_state() is done'
  \ | echohl NONE

