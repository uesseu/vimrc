"######################################################################
"# Source this file from vimrc or init.vim
"#=====================================================================
"# This file is very fast substitute of vimrc.
"######################################################################

set nocompatible
" Script directory
const s:scripts = '/scripts'
" Config directory
const s:config = '/config'
" Auto yielded config file name
const s:config_fname = '/config.vim'
" Dpp base path.
const s:base = expand('<script>:p:h').'/'
" Viminfo configuration. If neovim, it is called ShaDa.
let s:viminfo = "='20,<50,s10,:100"
" Dpp repositry path.
const s:dpp_github = s:base . 'repos/github.com/'
" Dpp configure script path.
const s:ts_config = s:base . s:scripts . '/config.ts'
" Denops shared server ip.
const g:denops_server_addr = '127.0.0.1:32123'
" Base repositryes of dpp. These are on github.
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

"######################################################################
"# Installer of DPP.
"#=====================================================================
"# If you want to reinstall the environment, remove the directory
"# named 'scripts/done'.
"######################################################################
if isdirectory(s:base . s:scripts .'/done') == 0
  exec "source ".s:base. s:scripts . 'install.vim'
  call Install(s:base_repos, s:base)
endif

"######################################################################
"# Load builtin plugins in lazy way
"######################################################################
set noloadplugins
au VimEnter * runtime! plugin/**/*.vim

"######################################################################
"# Set runtimepath and start core plugins.
"######################################################################
for repo in s:base_repos
  execute 'set runtimepath^=' .. s:dpp_github . repo
endfor

"######################################################################
"# DPP state loader
"#=====================================================================
"# Trigger of plugin manager DPP.
"######################################################################
autocmd User Dpp:makeStatePost echomsg 'State was made.'
if s:base->dpp#min#load_state()
  autocmd User DenopsReady call dpp#async_ext_action('installer', 'install')
  call dpp#make_state(s:base . s:scripts , s:ts_config)
endif

command! PluginInstall
    \ try
    \ | call dpp#make_state(s:base , s:ts_config)
    \ | call dpp#async_ext_action('installer', 'install')
    \ | catch
    \ | endtry
command! PluginUpdate 
    \ try
    \ | call dpp#make_state(s:base , s:ts_config)
    \ | call dpp#async_ext_action('installer', 'update')
    \ | catch
    \ | endtry
command! PluginApply
    \ try
    \ | call dpp#make_state(s:base , s:ts_config)
    \ | call s:make_configfile()
    \ | catch
    \ | endtry

"######################################################################
"# Vimrc writing commands
"#=====================================================================
"# Because this vimrc yields single vimrc from multiple files
"######################################################################
"
function s:writevimrc()
  autocmd BufWrite *.vim PluginApply
  for n in sort(globpath(s:base.s:config, '*.vim',0, 1))
    execute "e ".n
  endfor
  execute "cd ".s:base.s:config
endfunction

function s:writepluginconfig()
  autocmd BufWrite *.toml PluginApply
  for n in sort(globpath(s:base.'/plugin_config', '*.toml',0, 1))
    execute "e ".n
  endfor
  execute "cd ".s:base.'/plugin_config'
endfunction

command! Vimrc call s:writevimrc()
command! PluginConfig call s:writepluginconfig()

"######################################################################
"# Lazy load of syntax on
"#=====================================================================
"# This section sets syntax lazily. It is only for benchmark.
"######################################################################
filetype indent plugin on
if has('syntax')
  au VimEnter * syntax on
endif
au VimEnter * colorscheme retrobox

"######################################################################
"# Load configuration files
"#=====================================================================
"# This vimrc let you write multiple configuration files.
"# The order of files is numerical and alphabetical.
"# Ex: '1-init.vim', '2-fast.vim', 'bar.vim', 'foo.vim'
"######################################################################
let s:vimrc = []
function s:make_configfile()
  for n in sort(globpath(s:base. s:config, '*.vim',0, 1))
    let s:vimrc = s:vimrc + readfile(n)
  endfor
  call writefile(s:vimrc, s:base.s:scripts.s:config_fname, 'b')
endfunction

if !filereadable(s:base.s:scripts.s:config_fname)
  call s:make_configfile()
endif
execute "source ".s:base.s:scripts.s:config_fname
"######################################################################
"# Set limitation of viminfo or shada
"#=====================================================================
"# Viminfo is a storage of history of vim commands, marks and so on.
"# ShaDa is that of neovim. Setting limitation makes your vim fast.
"######################################################################
execute "set ".(has('nvim')?'shada':'viminfo').s:viminfo
