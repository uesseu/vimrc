"########################################
"# The installer script.
"# Needed for first boot or reinstall.
"########################################
echo 'This is the first time bootup. Please reboot after installing.'
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
call dpp#make_state(g:dpp_base, g:ts_config)
call denops_shared_server#install()

autocmd User DenopsReady :call dpp#make_state(g:dpp_base, g:ts_config)
qa
