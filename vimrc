"######################################################################
"# Source this file from vimrc or init.vim
"#=====================================================================
"# This file loads vim scripts from 'config' directory.
"# 'startup.vim', which is script for dpp is also loaded.
"######################################################################

const s:base = expand('<script>:p:h').'/'

execute 'source '.s:base.'startup.vim'

filetype indent plugin on
if has('syntax')
  au VimEnter * syntax on
endif

for n in globpath(s:base..'/config', '*.vim',0, 1)
  if !isdirectory(n)
    exec 'source '.n
  endif
endfor

let s:viminfo = "='20,<50,s10,:100"

execute "set ".(has('nvim')?'shada':'viminfo').s:viminfo
