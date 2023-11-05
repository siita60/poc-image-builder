FROM alpine:latest
# 公開するポート番号を指定
EXPOSE 80
# Entrypointで実行するコマンドをインストール
RUN apk add --no-cache net-tools
RUN apk add --no-cache nmap-nping
ENTRYPOINT ["nping", "-c", "3", "--tcp", "-p", "80"]
