![README_JP.md](README_JP.md)

# My vimrc in 2026
An example of vimrc. This is based on denops and dpp.
I wrote this because using dpp is not easy for me.
It is a manual for me in future.

# Feature

- Vim and neovim can be used!
- Crazy speed! Especially startup time!
- Easy to customize!(but, vim script not lua)

# Usage
Source the 'vimrc' in this repository from the vimrc or init.vim.

```vim
source [absolute source of vimrc]
```

Then boot vim twice.

# Files and directories
Files, user should edit.

- config
  + Alternate files of vimrc.
  + If the filename extension is vim, the script will be loaded.
  + The order is numerical and alphabetical.
  + All the files will be merged to one file.(for simplicity and speed)
- plugin_config
  + Toml files for dpp.

Files, user can edit.
- scripts/config.ts
  + File to configure dpp, written in typescript.

Files automatically made.

- vim: State directory of vim.
- nvim: State directory of neovim.
- repos: Repository of plugins.

Files you should not edit.
- installer/install.vim: Installer script
