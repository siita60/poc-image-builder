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

## 認証に必要な鍵の管理
どうやら GitHub 側の Settings ページで設定できるらしい。ここで設定したものはリポジトリに対して管理権限を持っていないと閲覧もできない雰囲気。

https://github.com/siita60/poc-image-builder/settings/secrets/actions

## 参考
* https://aws.amazon.com/jp/blogs/opensource/github-actions-aws-fargate/
* https://qiita.com/y_k_individual/items/064e058c5e280c161b7f
* https://zenn.dev/kou_pg_0131/articles/gh-actions-ecr-push-image

* Github Actions で AWS の認証を通す
  * https://docs.github.com/ja/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services

* ここに、role に指定する信頼ポリシーの例がある
  * https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create_GitHub

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::{ AWS account ID }:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          "token.actions.githubusercontent.com:sub": "repo:{organization or userID}/{repository name}:ref:refs/heads/{branch name}"
        }
      }
    }
  ]
}
```

# ハマりポイント

## Could Not credential なんか上手く認証できないらしい

```
Run aws-actions/configure-aws-credentials@v3
  with:
    role-to-assume: ***
    aws-region: ap-northeast-1
    audience: sts.amazonaws.com
```

このログで良いのか？

### GitHub Actions の secret 設定
* job の設定の中で、 environment 名を明確に指定しないと env や　secrets から値を取得できない？
* 参考
  * [[GitHub Actions] ブランチごとにジョブの実行を制御できる Environments を試してみた](https://dev.classmethod.jp/articles/github-actions-environment-secrets-and-environment-variables/)
  * []()