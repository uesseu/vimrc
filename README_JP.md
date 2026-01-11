![英語版](README.md)

# 僕の2026年のvimrc
僕の2026年のvimrcの雛形。
Dppの設定はそんなに簡単じゃあないので、これは未来の僕のためのマニュアルです。

# 特徴

- 戦闘力低め
- Vimもneovimも動く。
- 遅くはない。多分。
- カスタマイズは簡単(ただしvim script、luaじゃないです)
- [dpp.vim](https://github.com/Shougo/dpp.vim)を採用してる。
- プリセットを準備している。(これで個人的設定と公開設定を切りわけられる)

# 使い方
presetsディレクトリの中のtomlファイルの中に何をインストールするのかを記載できます。
vimrcの中で、このリポジトリの中のvimrcというファイルを読みこみます。
tomlファイルは複数配置できます。gitリポジトリをcloneするので、自分でリポジトリを作るのがいいでしょう。

```vim
source [absolute source of vimrc]
```

そんで、2回ほどvimを起動して下さい。


# 設定
設定を反映する。```PluginConfig```や```Vimrc```コマンドを使う場合は不要。

```vim
PluginApply
```

プラグインの設定用のtomlを弄る。Tomlファイル群は
```plugin_config```にあって、その中の複数のディレクトリに配置されている。
```vim
PluginConfig [plugins]
```

設定ファイルを弄る。このvimrcは複数の小さなファイルにわかれていて、
あとでそれを統合する。この方法によって、速度と管理しやすさの両立を目指した。
```vim
Vimrc [config_file]
```

プラグインをインストールする。もし自分でプラグインのtomlを弄ったなら、これを走らせる。
```vim
PluginInstall
```

プラグインをアップデートする。
```vim
PluginUpdate
```

プラグインを消す。もしこれを動かしたら、次回起動時にvimはプラグインを再インストールしようとする。
```vim
PluginReset
```


