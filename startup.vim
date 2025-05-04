"########################################
"# Start up script for denops and dpp.
"########################################

set nocompatible

" Dpp base path.
const g:dpp_base = expand('<script>:p:h').'/'
" Dpp repositry path.
const g:dpp_github = g:dpp_base . 'repos/github.com/'
" Dpp configure script path.
const g:ts_config = g:dpp_base.'config.ts'
" Denops shared server ip.
const g:denops_server_addr = '127.0.0.1:32123'

" Base repositryes of dpp.
" These are on github.
const g:base_repos = [
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
if isdirectory(g:dpp_github . 'Shougo/dpp.vim') == 0
  exec "source ".g:dpp_base.'installer/install.vim'
endif

" Set runtimepath and start core plugins.
for repo in g:base_repos
  execute 'set runtimepath^=' .. g:dpp_github . repo
endfor

" Load startup scripts of dpp state.
if g:dpp_base->dpp#min#load_state()
  echo 'Installing plugins'
  call dpp#async_ext_action('installer', 'install')
  " When failed loading state.
  autocmd User DenopsReady
  \ : echohl WarningMsg
  \ | echomsg 'dpp load_state() is failed'
  \ | echohl NONE
  \ | call dpp#make_state(s:dpp_base, s:ts_config)
endif

" After making state.
autocmd User Dpp:makeStatePost
  \ : echohl WarningMsg
  \ | echomsg 'dpp make_state() is done'
  \ | echohl NONE

" Clean up.
const s:dpp_base = g:dpp_base
const s:ts_config = g:ts_config
unlet g:dpp_github
unlet g:dpp_base
unlet g:ts_config
unlet g:base_repos
