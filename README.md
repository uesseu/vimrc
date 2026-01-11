![README_JP.md](README_JP.md)

# My vimrc in 2026
An example of vimrc. This is based on denops and dpp.
I wrote this because using dpp is not easy for me.
It is a manual for me in future.

# Feature
- Vim and neovim can be used.
- Not so slow I think.
- Easy to edit.(Because I am a novice)
- Based on [dpp.vim](https://github.com/Shougo/dpp.vim).
- With presets.(By this, I can divide private and public vimrc.)

# Usage
You can edit toml files in presets/ to select plugins.
Source the 'vimrc' in this repository from the vimrc or init.vim.
This vimrc clones git repositories and so, lets make repositories!

```vim
source [absolute source of vimrc]
```

Then boot vim twice.

# Configuration commands
Apply configuration. If you use ```PluginConfig``` or ```Vimrc``` command, 
it may not be needed.
```vim
PluginApply
```

Edit plugin tomls.
The plugins tomls are placed in ```plugin_config``` and
it is divided in to multiple directoried.
```vim
PluginConfig [plugins]
```

Edit configuration files. My vimrc is divided in to
multiple small scripts and they are merged into big vimrc.
This makes my vimrc easy to management and fast to boot.
```vim
Vimrc [config_file]
```

Install plugins. If you edit plugin tomls, you shoudl run it.
```vim
PluginInstall
```

Update plugins.
```vim
PluginUpdate
```

Erase plugins. If you run it, vim will try to re-install plugins again.
```vim
PluginReset
```


