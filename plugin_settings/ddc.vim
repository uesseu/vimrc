"=============================
"# Settings
"=============================

" Customize global settings

" You must set the default ui.
" Note: native ui

" https://github.com/Shougo/ddc-ui-native
function! s:start_ddc()
  call ddc#custom#patch_global('ui', 'native')

  " call ddc#custom#patch_global('completionMenu', 'pum.vim')
  call ddc#custom#patch_global('sourceOptions', {
    \   '_': {
    \     'matchers': ['matcher_fuzzy'],
    \     'sorters': ['sorter_fuzzy'],
    \     'converters': ['converter_fuzzy']
    \   }
    \ })

  " Use around source.
  call ddc#custom#patch_global('sources', ['around'])
  call ddc#custom#patch_global('sourceOptions', #{around: #{ mark: 'A' },})
  call ddc#custom#patch_global('sourceParams', #{around: #{ maxSize: 500 },})
  call ddc#custom#patch_global('sources', ['vim-lsp'])
  call ddc#custom#patch_global('sourceOptions', #{
	\   vim-lsp: #{
	\     mark: 'lsp',
	\     forceCompletionPattern: '\w+|\.\w*|:\w*|->\w*' },
	\ })
  call ddc#enable()
endfunction

if v:vim_did_enter
  call s:start_ddc()
else
  au VimEnter * call s:start_ddc()
endif

