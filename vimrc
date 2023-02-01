"========================================
"# Ninjas_vimrc
"========================================
" This is my vimrc, which is fast rich and easy to manage.
" If you want to read details or TOF, type Ctr-] on word below.
" README:
" Tof_Table_of_contents:
"
" This setting is needed if you want to use links.
" If you do not want to use, just comment it out.
set ignorecase

"========================================
"# Basic_config
"========================================
" This section is basic config.
" You should write path and filenames.
" Names of plugins should be written in other file.

let g:vimrc_dir = $HOME."/dotfiles/vim"

" Scripts need to be read at first
let s:no_lazy_vimrc = ['plugin_manage.vim']

" Scripts need not to be read at first
let s:lazy_vimrc = ['settings.vim']

" Link to list of script to read plugins
" Plugin_manage_Plugins:

" If you need not use standard plugins you can set noplugins option
" set noloadplugins


"========================================
"# Load_vimscripts
"========================================
for s:vimrc in s:no_lazy_vimrc
  exe 'source '.g:vimrc_dir.'/'.s:vimrc
endfor

function! s:startup()
  for s:vimrc in s:lazy_vimrc
    exe 'source '.g:vimrc_dir.'/'.s:vimrc
  endfor
endfunction

if v:vim_did_enter
  call s:startup()
else
  au VimEnter * call s:startup()
endif

"========================================
"# Make_vim_TOF
"========================================
function! MakeVimrcTOF()
  call system('deno run --allow-read '.g:vimrc_dir.'/make_tags.ts'.' '.g:vimrc_dir.'/ --toc' .' > '.g:vimrc_dir.'/tof.vim')
  call system('deno run --allow-read '.g:vimrc_dir.'/make_tags.ts'.' '.g:vimrc_dir.'/ --tag' .' > '.g:vimrc_dir.'/tags')
endfunction

