![英語版](README.md)

# 僕の2025年のvimrc
僕の2025年のvimrcの雛形。これはdenopsとdppを使ったもの。
Dppの設定はそんなに簡単じゃないので、これは未来の僕のためのマニュアルです。

# 使い方
vimrcの中で、このリポジトリの中のvimrcというファイルを読みこみます。

```vim
source [absolute source of vimrc]
```

そんで、2回ほどvimを起動して下さい。

# ファイルとディレクトリ
ユーザーが編集すべきファイル群

- config
  + vimrcの代りです。
  + もし拡張子がvimだったら読みこまれます。
  + 読まれる順序は考慮されません。
- plugin_config
  + Dppのためのtomlファイル群です。
- config.ts
  + Typescriptで書かれたDppの設定ファイルです。

自動で生成されるファイル群

- vim: vimの為のstate file。
- nvim: neovimの為のstate file。
- repos: プラグインのリポジトリ群。

# 利点

- Vimもneovimも動きます！
- 超速！
- 自由度！
