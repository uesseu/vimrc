"========================================
"# Ninjas_vimrc
"========================================
" This is my vimrc, which is fast rich and easy to manage.
" Requires deno.
"
"========================================
"# Install
"========================================
" This vimrc was made in ubuntu.
" Make link to $HOME/.vimrc or $HOME/.config/nvim/init.vim.
" Some plugins requires deno.
"========================================
"# Making_TOF
"========================================
" You can yield table of contents by this command
" :call MakeVimTOF()
" The table of contents is link to each section.
" The section name should start by three characters ["# ]
" and should not involve spaces.
" Do not make label which name is same as others.
"
" If you want to goto table of contents,
" Ctr-] on next line. It is just a vim script.
" Tof_Table_of_contents:


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
function! MakeVimTOF()
  call system('deno run --allow-read '.g:vimrc_dir.'/make_tags.ts'.' '.g:vimrc_dir.'/ --toc' .' > '.g:vimrc_dir.'/tof.vim')
  call system('deno run --allow-read '.g:vimrc_dir.'/make_tags.ts'.' '.g:vimrc_dir.'/ --tag' .' > '.g:vimrc_dir.'/tags')
endfunction

