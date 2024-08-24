# narou_docker

## 概要

WEB小説からの電子書籍データ変換支援ツール[Narou.rb](https://github.com/whiteleaf7/narou)をDocker上で動作させます。

## 初回のみの作業

### ファイル変換に必要なツールをダウンロード

#### AozoraEpub3のダウンロード

[AozoraEpub3](https://github.com/kyukyunyorituryo/AozoraEpub3/releases/tag/v1.1.1b24Q)から**AozoraEpub3-1.1.1b24Q.zip**をダウンロードします。

Dockerfileと同じ階層に配置します。

上記と異なるバージョンを使用する場合はDockerfileの環境変数を変更します。

#### kindlegenのダウンロード

[fp-docker](https://github.com/zzet/fp-docker)から**kindlegen_linux_2.6_i386_v2_9.tar.gz**をダウンロードします。

Dockerfileと同じ階層に配置します。

上記と異なるバージョンを使用する場合はDockerfileの環境変数を変更します。

### narou.rbの起動

以下のコマンドを実行します。

`docker compose up -d --build`

### narou.rbへアクセス

以下のアドレスでアクセスします。

<http://localhost:8200/>
