# これは
GitHub Action で docker image を build して、ECR に push することを試す Repository

## ローカルで作って push するまで
### image作成

```bash
$ docker image build -t sample/ping:latest .
$ docker container run -p 80:80 --name ping  sample/ping:latest www.google.co.jp
$ docker container commit ping sample/ping:latest
```

### push
ECR に repository 作って、手順に沿ってpush

TODO: 詳細

## 参考
* https://qiita.com/y_k_individual/items/064e058c5e280c161b7f
* https://zenn.dev/kou_pg_0131/articles/gh-actions-ecr-push-image
