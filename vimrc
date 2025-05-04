"######################################################################
"# Source this file from vimrc or init.vim
"#=====================================================================
"# This file loads vim scripts from 'config' directory.
"# 'startup.vim', which is script for dpp is also loaded.
"######################################################################

const s:base = expand('<script>:p:h').'/'
execute 'source '.s:base.'startup.vim'

for n in globpath(s:base..'/config', '*.vim',0, 1)
  if !isdirectory(n)
    exec 'source '.n
  endif
endfor
