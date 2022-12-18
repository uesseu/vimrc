# Ninja's vimrc
This is my vimrc, which is fast rich and easy to manage.

# Requirement
- vim or neovim
- deno
- git

# Install
This vimrc was made in ubuntu.
Make link to $HOME/.vimrc or $HOME/.config/nvim/init.vim.
Some plugins requires deno.

# Making_TOF
You can yield table of contents by this command

```
:call MakeVimTOF()
```

The table of contents is link to each section.
The section name should start by three characters '"# '
and should not involve spaces.
Do not make label which name is same as others.

If you want to goto table of contents,
Ctr-\] on next line. It is just a vim script.

```
Tof_Table_of_contents:
```
