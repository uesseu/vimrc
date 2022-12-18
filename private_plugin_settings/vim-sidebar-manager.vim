"========================================
"# Settings
"========================================
" brglng/vim-sidebar-manager makes UI like sidebar of IDE.
" In this section, various sidebars are registered.
let g:tagbar_left = 0
let g:tagbar_width = 20
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 20
noremap <Leader>1 :call sidebar#toggle('fern')<CR>
noremap <Leader>2 :call sidebar#toggle('tagbar')<CR>
noremap <Leader>3 :call sidebar#toggle('undotree')<CR>
noremap <Leader>4 :call sidebar#toggle('loclist')<CR>
noremap <Leader>5 :call sidebar#toggle('quickfix')<CR>

let g:sidebars = {
  \ 'tagbar': {
  \     'position': 'right',
  \     'check_win': {nr -> bufname(winbufnr(nr)) =~ '__Tagbar__'},
  \     'open': 'TagbarOpen',
  \     'close': 'TagbarClose'
  \ },
  \ 'undotree': {
  \     'position': 'left',
  \     'check_win': {nr -> getwinvar(nr, '&filetype') ==# 'undotree'},
  \     'open': 'UndotreeShow',
  \     'close': 'UndotreeHide'
  \ },
  \ 'quickfix': {
  \     'position': 'bottom',
  \     'check_win': {nr -> getwinvar(nr, '&filetype') ==# 'qf' && !getwininfo(win_getid(nr))[0]['loclist']},
  \     'open': 'copen',
  \     'close': 'cclose'
  \ },
  \ 'loclist': {
  \     'position': 'bottom',
  \     'check_win': {nr -> getwinvar(nr, '&filetype') ==# 'qf' && getwininfo(win_getid(nr))[0]['loclist']},
  \     'open': 'silent! lopen',
  \     'close': 'silent! lclose'
  \ },
  \ 'fern': {
  \     'position': 'left',
  \     'check_win': {nr -> getwinvar(nr, '&filetype') ==# 'fern'},
  \     'open': 'Fern . -drawer -toggle -width=20',
  \     'close': 'Fern . -drawer -toggle -width=20'
  \ }
  \ }

