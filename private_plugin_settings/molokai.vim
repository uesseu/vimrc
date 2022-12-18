"========================================
"# Theme
"========================================
let g:molokai_original = 1
if v:vim_did_enter
  colorscheme molokai
else
  au VimEnter * colorscheme molokai
endif
