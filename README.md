# Ninja's vimrc
This is my basic vimrc, which is fast simple and easy to manage.  
Since, this vimrc is 'basic', it is not rich.  
I build my local environment on this.

# Requirement
- vim or neovim
- deno
- git

# Install
This vimrc was made in ubuntu.
Make link to $HOME/.vimrc or $HOME/.config/nvim/init.vim.
Some plugins requires deno.

# Added plugins
This vimrc adds some plugins, because installing such plugins are little bit tiring.

- roxma/nvim-yarp
- roxma/vim-hug-neovim-rpc
- prabirshrestha/vim-lsp
- mattn/vim-lsp-settings
- vim-denops/denops.vim
- Shougo/ddc.vim
- Shougo/ddc-ui-native
- Shougo/ddc-source-around
- shun/ddc-vim-lsp
- LumaKernel/ddc-file
- Shougo/ddc-converter_remove_overlap
- tani/ddc-fuzzy

# Feature
This vimrc can be read by vim and neovim.
By this vimrc, on my computer, neovim starts up in 11ms.
Since vimrc sometimes become big and not easy to manage,
I made function to make TOF of vimrc.

# Making_TOF
You can yield table of contents by this command.

```
:call MakeVimrcTOF()
```

The table of contents is link to each section.
The section name should start by three characters '"# '
and should not involve spaces.
Do not make label which name is same as others.

If you want to goto table of contents,
Ctr-\] on next line. It is just a vim script.

```
" Tof__Table_of_contents:
```

# Link format
```
FileName__sectionname
```

File name is capital case and '.vim' should be removed.  
After filename, ```__``` is set between section name.  
And I can make link to other section.

This makes me jump between plugin manager script and settings.

# My way to make section
I think, if section name, related links and comments are written in same place, vimrc is easy to manage.

```
"========================================
"# Complete
"========================================
" Plugin_settings__ddc:
" Plugins for completion based on ddc.
```

# Why I made this vimrc public
Ofcourse, vimrc is personal file. However, I made it public.
I wanted to share my vimrc between my computers.
It was tiring for me to do that as private repogitory.
This simple reason is why I made this public.
And so, it is public and personal vimrc.

# License
MIT
