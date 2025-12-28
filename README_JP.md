![英語版](README.md)

# 僕の2026年のvimrc
僕の2026年のvimrcの雛形。
Dppの設定はそんなに簡単じゃないので、これは未来の僕のためのマニュアルです。

# 特徴

- Vimもneovimも動きます！
- 頭おかしいくらい速い！特に起動速度！
- カスタマイズ簡単！(ただしvim script、luaじゃないです)

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
  + 読まれる順序は数字、文字の順です。
  + 全てのファイルは一つのファイルに統合されます。(シンプルさと速さのため)
- plugin_config
  + Dppのためのtomlファイル群です。

ユーザーが編集してもしなくてもいいもの
- scripts/config.ts
  + Typescriptで書かれたDppの設定ファイルです。

自動で生成されるファイル群

- vim: vimの為のstate file。
- nvim: neovimの為のstate file。
- repos: プラグインのリポジトリ群。
