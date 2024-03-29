"========================================
"# About_this
"========================================
" I selected dein as plugin manager.
" This script is based on example of dein.

"========================================
"# Files
"========================================
" This vimrc is based on dein which is fast plugin manager.
" 
" Dein needs vimscript or toml files.
" In this vimrc, we read files below.
" If you want fast vim, you should not make these array too big.
"
" Scripts involvs dein#add
let s:plugin_sources = ['plugins.vim']
" Plugins__About_this:

" Directory of scripts of plugin specific settings
let s:plugin_settings = ['plugin_settings.vim']
" Plugin_settings__About_this:

if &compatible
  set nocompatible " Be iMproved
endif

"========================================
"# Some_local_settings
"========================================
let g:dein#auto_recache = 1
let s:dein_dir_local = '~/.local/share/dein'
let s:dein_dir = expand(s:dein_dir_local)

"========================================
"# Install_itself
"========================================
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
execute 'set runtimepath+='.s:dein_repo_dir

"========================================
"# Manage_plugins
"========================================
call dein#begin(s:dein_dir)
call dein#add(s:dein_repo_dir)
for s:plugin_source in s:plugin_sources
  exe 'source '.g:vimrc_dir.'/'.s:plugin_source
endfor
call dein#end()

"========================================
"# Required_settings
"========================================
filetype plugin indent on
syntax enable

"========================================
"# Install_plugins
"========================================
function! s:check_install()
  if dein#check_install()
   call dein#install()
  endif
endfunction

if v:vim_did_enter
  call s:check_install()
else
  au VimEnter * call s:check_install()
endif

"=============================
"# Read_settings_of_plugins
"=============================
for file in s:plugin_settings
  exe 'source '.g:vimrc_dir.'/'.file
endfor
