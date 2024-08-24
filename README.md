# narou_docker

## 概要

WEB小説からの電子書籍データ変換支援ツール[Narou.rb](https://github.com/whiteleaf7/narou)をDocker上で動作させます。

## 準備

初回のみファイルのダウンロードと配置が必要です。

### ファイル変換に必要なツールをダウンロード

#### AozoraEpub3のダウンロード

[AozoraEpub3](https://github.com/kyukyunyorituryo/AozoraEpub3/releases/tag/v1.1.1b24Q)から**AozoraEpub3-1.1.1b24Q.zip**をダウンロードします。

Dockerfileと同じ階層に配置します。

上記と異なるバージョンを使用する場合はDockerfileの環境変数を変更します。

#### kindlegenのダウンロード

[fp-docker](https://github.com/zzet/fp-docker)から**kindlegen_linux_2.6_i386_v2_9.tar.gz**をダウンロードします。

Dockerfileと同じ階層に配置します。

上記と異なるバージョンを使用する場合はDockerfileの環境変数を変更します。

## 使い方

### narou.rbの起動

以下のコマンドを実行します。

`docker compose up -d --build`

### narou.rbへアクセス

以下のアドレスでアクセスします。

<http://localhost:8200/>

## 環境移行

### 他環境の小説データをDocker環境に移行

**念のため環境移行の失敗に備えてバックアップを取ってから実行してください。**

基本的に小説データを保持している以下のフォルダ構造をそのまま`novel_data`フォルダにコピーすればよいですが、少し注意が必要です。

```text
novel_data
    - .narou
    - .narousetting
    - 小説データ
```

**必ず小説データの移行前に一度コンテナを起動してください。**\
起動時に`novel_data`フォルダにnarou.rbの軌道に必要な設定ファイルが作成されます。

<http://localhost:8200/>にアクセスして正常に起動出来たことを確認した後`docker compose down`でコンテナを終了します。

他の環境で管理していた小説データを「novel_data」フォルダにコピーします。\
基本的に上書き保存でよいです。

`docker compose up -d`でコンテナを立ち上げ、narou.rbの管理ページにアクセスします。

正常に起動出来ない場合はブラウザに`このサイトにアクセスできません`などと表示されます。
正常に起動できない場合`novel_data`フォルダの`trace_dump.txt`にエラーログが残っていることがあります。\
参考にして問題を解決します。

なお、上記手順を行わず初回起動前にデータを移行した際には以下のエラーログが表示されサービスが起動しませんでした。

```log
--- 2024/08/24 17:15:50 ---
/usr/local/bundle/bin/narou web -p 8200 -n --boot

/usr/local/bundle/gems/narou-3.9.0/lib/command/web.rb:56:in `getch': Inappropriate ioctl for device (Errno::ENOTTY)
  from /usr/local/bundle/gems/narou-3.9.0/lib/command/web.rb:56:in `confirm_of_first'
  from /usr/local/bundle/gems/narou-3.9.0/lib/command/web.rb:119:in `boot'
  from /usr/local/bundle/gems/narou-3.9.0/lib/command/web.rb:87:in `execute'
  from /usr/local/bundle/gems/narou-3.9.0/lib/commandbase.rb:125:in `execute!'
  from /usr/local/bundle/gems/narou-3.9.0/lib/commandbase.rb:134:in `execute!'
  from /usr/local/bundle/gems/narou-3.9.0/lib/commandline.rb:29:in `run'
  from /usr/local/bundle/gems/narou-3.9.0/lib/commandline.rb:43:in `run!'
  from /usr/local/bundle/gems/narou-3.9.0/narou.rb:50:in `block in <top (required)>'
  from /usr/local/bundle/gems/narou-3.9.0/lib/backtracer.rb:16:in `capture'
  from /usr/local/bundle/gems/narou-3.9.0/narou.rb:49:in `<top (required)>'
  from /usr/local/bundle/gems/narou-3.9.0/bin/narou:13:in `require_relative'
  from /usr/local/bundle/gems/narou-3.9.0/bin/narou:13:in `<top (required)>'
  from /usr/local/bundle/bin/narou:25:in `load'
  from /usr/local/bundle/bin/narou:25:in `<main>'
```
