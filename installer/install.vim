"########################################
"# The installer script.
"# Needed for first boot or reinstall.
"########################################
echo 'This is the first time bootup. Please reboot after installing.'

if isdirectory(g:dpp_base . 'installer/to_makestate') == 0
  call mkdir(g:dpp_github, 'p')
  for repo in g:base_repos
    exec "cd ".g:dpp_github
    let s:tmp_repo_path = repo->split('/')
    if isdirectory(s:tmp_repo_path[0]) == 0
      call mkdir(s:tmp_repo_path[0])
    endif
    exec "cd ".s:tmp_repo_path[0]
    if isdirectory(s:tmp_repo_path[1]) == 0
      echo system("git clone https://github.com/".repo)
    endif
  endfor
  
  for repo in g:base_repos
    execute 'set runtimepath^=' .. g:dpp_github . repo
  endfor
  
  call denops_shared_server#install()
  call mkdir(g:dpp_base.'installer/to_makestate')
  qa
elseif isdirectory(g:dpp_base . 'installer/to_install') == 0
  for repo in g:base_repos
    execute 'set runtimepath^=' .. g:dpp_github . repo
  endfor
  autocmd User Dpp:makeStatePost :qa
  call dpp#make_state(g:dpp_base, g:ts_config)
  call mkdir(g:dpp_base.'installer/to_install')
else
  for repo in g:base_repos
    execute 'set runtimepath^=' .. g:dpp_github . repo
  endfor

  call delete(g:dpp_base.'installer/to_install', 'rf')
  call delete(g:dpp_base.'installer/to_makestate', 'rf')
  call dpp#min#load_state(g:dpp_base)
  call dpp#async_ext_action('installer', 'install')
  call mkdir(g:dpp_base.'installer/done')
endif
