"######################################################################
"# Source this file from vimrc or init.vim
"#=====================================================================
"# From here you can configure vimrc
"######################################################################
" Give denops server all the privilleges.

let g:denops#server#deno_args = ['-A']
" Denops shared server ip.
const g:denops_server_addr = '127.0.0.1:32123'
set nocompatible
" Script directory
const s:scripts = '/scripts'
" Config directory
const s:config = '/config'
" Auto yielded config file name
const s:config_fname = '/config.vim'
" Dpp base path.
const s:dpp_base = expand('<script>:p:h').'/'
" Viminfo configuration. If neovim, it is called ShaDa.
let s:viminfo = "='20,<50,s10,:100"
" Dpp repositry path.
const s:dpp_github = s:dpp_base . 'repos/github.com/'
" Dpp configure script path.
const s:ts_config = s:dpp_base . 'scripts/config.ts'
" Base repositryes of dpp. These are on github.
const s:base_repos = [
      \'vim-denops/denops-shared-server.vim',
      \'vim-denops/denops.vim',
      \'Shougo/dpp-ext-lazy',
      \'Shougo/dpp-protocol-git',
      \'Shougo/dpp-ext-toml',
      \'Shougo/dpp-ext-local',
      \'Shougo/dpp-ext-installer',
      \'Shougo/dpp.vim',
      \]



let s:lazy_builtin_plugins = v:true
for arg in argv()
  if isdirectory(arg)
    let s:lazy_builtin_plugins = v:false
  endif
endfor

"######################################################################
"# Installer of DPP.
"#=====================================================================
"# If you want to reinstall the environment, remove the directory
"# named 'scripts/done'.
"######################################################################
if isdirectory(s:dpp_base . s:scripts .'/done') == 0
  exec "source ".s:dpp_base. s:scripts . '/install.vim'
  call Install(s:base_repos, s:dpp_base, s:scripts)
endif

if !s:lazy_builtin_plugins
  set loadplugins
endif
"######################################################################
"# Set runtimepath and start dpp.vim
"#=====================================================================
"# Stop loading plugins for lazy loading.
"######################################################################
if has('syntax')
  au VimEnter * syntax on
endif

for repo in s:base_repos
  execute 'set runtimepath^=' .. s:dpp_github . repo
endfor

"######################################################################
"# DPP state loader
"#=====================================================================
"# Trigger of plugin manager DPP.
"######################################################################
autocmd User Dpp:makeStatePost echomsg 'State was made.'
function s:make_and_load_state()
  call dpp#make_state(s:dpp_base, s:ts_config)
  call dpp#min#load_state(s:dpp_base)
endfunction
if dpp#min#load_state(s:dpp_base)
  echomsg 'Failed to load'
  autocmd User DenopsReady call s:make_and_load_state()
endif

command! PluginInstall
    \ try
    \ | echo dpp#sync_ext_action('installer', 'install')
    \ | silent! call dpp#make_state(s:dpp_base, s:ts_config)
    \ | call s:make_configfile()
    \ | catch
    \ | endtry

command! PluginUpdate 
    \ try
    \ | call dpp#sync_ext_action('installer', 'update')
    \ | silent! call dpp#make_state(s:dpp_base, s:ts_config)
    \ | call s:make_configfile()
    \ | catch
    \ | endtry

command! PluginApply
    \ try
    \ | call dpp#make_state(s:dpp_base, s:ts_config)
    \ | call s:make_configfile()
    \ | catch
    \ | endtry

command! PluginReset
    \ try
    \ | call delete(s:dpp_base.(has('nvim')? 'nvim': 'vim'), 'rf')
    \ | call delete(s:dpp_base.s:scripts.s:config_fname)
    \ | call delete(s:dpp_base.s:scripts.'/done', 'rf')
    \ | call delete(s:dpp_base.'/repos', 'rf')
    \ | catch
    \ | endtry

"######################################################################
"# Vimrc writing commands
"#=====================================================================
"# Because this vimrc yields single vimrc from multiple files
"######################################################################
function s:writevimrc(fname)
  autocmd BufWrite *.vim PluginApply
  execute "cd ".s:dpp_base.s:config
  execute "e ".a:fname
endfunction

function s:writepluginconfig(dirname)
  autocmd BufWrite *.toml PluginApply
  execute "cd ".s:dpp_base.'/plugin_config/'.a:dirname
  execute "Explore ".s:dpp_base.'/plugin_config/'.a:dirname
endfunction

function s:vimrccomp(ArgLead, CmdLine, CursorPos)
  return readdir(s:dpp_base.s:config)
endfunction
command! -nargs=1 -complete=customlist,s:vimrccomp Vimrc call s:writevimrc(<f-args>)

function s:pluginconfigcomp(ArgLead, CmdLine, CursorPos)
  return readdir(s:dpp_base.'/plugin_config')
endfunction
command! -nargs=1 -complete=customlist,s:pluginconfigcomp PluginConfig call s:writepluginconfig(<f-args>)

"######################################################################
"# Load configuration files
"#=====================================================================
"# You can write multiple configuration files. This vimrc merges them.
"# The order of files is numerical and alphabetical.
"# Ex: '1-init.vim', '2-fast.vim', 'bar.vim', 'foo.vim'
"######################################################################
function s:make_configfile() 
  let vimrc = []
  call delete(s:dpp_base.s:scripts.s:config_fname)
  for n in sort(globpath(s:dpp_base. s:config, '*.vim',0, 1))
    if n->split('/')[-1][0] != '_'
      let vimrc = vimrc + readfile(n)
    endif
  endfor
  call writefile(vimrc, s:dpp_base.s:scripts.s:config_fname, 'b')
endfunction

if !filereadable(s:dpp_base.s:scripts.s:config_fname)
  call s:make_configfile()
        \|execute "source ".s:dpp_base.s:scripts.s:config_fname
else
  execute "source ".s:dpp_base.s:scripts.s:config_fname
endif

"######################################################################
"# Set limitation of viminfo or shada
"#=====================================================================
"# Viminfo is a storage of history of vim commands, marks and so on.
"# ShaDa is that of neovim. Setting limitation makes your vim fast.
"######################################################################
execute "set ".(has('nvim')?'shada':'viminfo').s:viminfo
filetype on

"######################################################################
"# Lazy load of builtin plugins
"#=====================================================================
"# For boot speed, this vimrc reads builtin plugins lazily.
"######################################################################
if s:lazy_builtin_plugins
  set noloadplugins
  au VimEnter * runtime! plugin/**/*.vim
endif

