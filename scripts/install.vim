"########################################
"# The installer script.
"# Needed for first boot or reinstall.
"########################################


function Install(base_repos, dpp_base, scripts)
  echomsg 'This is the first time bootup. It will automatically reboot after installation.'
  const presets = json_decode(system("deno -A ".a:dpp_base."/scripts/presets.ts"))
  if isdirectory(a:dpp_base.'/plugin_config') == 0
    call mkdir(a:dpp_base.'/plugin_config')
  endif
  exec "cd ".a:dpp_base.'/plugin_config'
  for name in keys(presets)
    if isdirectory(name) == 0
      echo "git clone ".presets[name]['url']." ".name
      call system("git clone ".presets[name]['url']." ".name)
    endif
  endfor
  exec "cd ".a:dpp_base
  const dpp_github = a:dpp_base . 'repos/github.com/'
  const s:ts_config = a:dpp_base . 'scripts/config.ts'
  const s:scripts = a:scripts
  call mkdir(dpp_github, 'p')
  exec "cd ".dpp_github
  for repo in a:base_repos
    exec "cd ".dpp_github
    let tmp_repo_path = repo->split('/')
    if isdirectory(tmp_repo_path[0]) == 0
      call mkdir(tmp_repo_path[0])
    endif
    exec "cd ".tmp_repo_path[0]
    let jobs = []
    if isdirectory(tmp_repo_path[1]) == 0
      echo "git clone https://github.com/".repo
      call system("git clone https://github.com/".repo)
    else
      echo "exists https://github.com/".repo
    endif
  endfor
  exec "cd ".a:dpp_base
  for repo in a:base_repos
    execute 'set runtimepath^=' . dpp_github . repo
  endfor
  set loadplugins
  runtime! plugin/**/*.vim
  silent! call denops_shared_server#install()
  const s:dpp_base = a:dpp_base
  autocmd User DenopsReady call s:install_plugins()
endfunction

function s:install_plugins()
  call dpp#min#load_state(s:dpp_base)
  call dpp#make_state(s:dpp_base, s:ts_config)
  2sleep
  call dpp#min#load_state(s:dpp_base)
        \|echo dpp#sync_ext_action('installer', 'install')
        \|call dpp#make_state(s:dpp_base, s:ts_config)
        \|call mkdir(s:dpp_base.s:scripts.'/done')
        \|echomsg "Restart vim!"
        \|qa
endfunction
