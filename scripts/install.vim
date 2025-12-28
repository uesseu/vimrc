"########################################
"# The installer script.
"# Needed for first boot or reinstall.
"########################################
echo 'This is the first time bootup. Please reboot after installing.'
const s:dpp_github = s:base . 'repos/github.com/'
const s:ts_config = s:base . s:scripts . '/config.ts'

function Install(base_repos, dpp_base)
  if isdirectory(a:dpp_base . 'installer/to_makestate') == 0
    call mkdir(s:dpp_github, 'p')
    for repo in a:base_repos
      exec "cd ".s:dpp_github
      let s:tmp_repo_path = repo->split('/')
      if isdirectory(s:tmp_repo_path[0]) == 0
        call mkdir(s:tmp_repo_path[0])
      endif
      exec "cd ".s:tmp_repo_path[0]
      if isdirectory(s:tmp_repo_path[1]) == 0
        echo system("git clone https://github.com/".repo)
      endif
    endfor
    
    for repo in a:base_repos
      execute 'set runtimepath^=' .. s:dpp_github . repo
    endfor
    
    call denops_shared_server#install()
    call mkdir(a:dpp_base.'installer/to_makestate')
    qa
  elseif isdirectory(a:dpp_base . 'installer/to_install') == 0
    for repo in a:base_repos
      execute 'set runtimepath^=' .. s:dpp_github . repo
    endfor
    call mkdir(a:dpp_base.'installer/to_install')
    autocmd User Dpp:makeStatePost :qa
    call dpp#make_state(a:dpp_base, s:ts_config)
  else
    for repo in a:base_repos
      execute 'set runtimepath^=' .. s:dpp_github . repo
    endfor

    call delete(a:dpp_base.'installer/to_install', 'rf')
    call delete(a:dpp_base.'installer/to_makestate', 'rf')
    call dpp#make_state(a:dpp_base, s:ts_config)
    call dpp#min#load_state(a:dpp_base)
    call dpp#async_ext_action('installer', 'install')
    call mkdir(a:dpp_base.'installer/done')
  endif
endfunction
