"=============================
"# Settings
"=============================

function! s:start_ddc()
  call ddc#custom#patch_global('ui', 'native')
  call ddc#custom#patch_global('sourceParams', #{around: #{ maxSize: 500 },})
  call ddc#custom#patch_global('sources', ['vim-lsp', 'around'])
  call ddc#custom#patch_global('sourceOptions', #{
        \   _: #{
        \     matchers: ['matcher_fuzzy'],
        \     sorters: ['sorter_fuzzy'],
        \     converters: ['converter_fuzzy']
        \   },
	\   around: #{ mark: 'Around' },
	\   vim-lsp: #{
	\     mark: 'LSP',
	\     forceCompletionPattern: '\w+|\.\w*|:\w*|->\w*' },
\ })
  call ddc#enable()
endfunction

if v:vim_did_enter
  call s:start_ddc()
else
  au VimEnter * call s:start_ddc()
endif

