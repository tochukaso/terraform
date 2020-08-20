# The purpose of this repository

To test Terraform

## Lambda functionのビルドについて

    $ sh build-lambda.sh

## SQSでリトライ出来るか確認する方法

    Lambda functionのビルド
    $ sh build-lambda.sh

    Terraformによるリソースの作成
    $ terraform init
    $ terraform apply

    AWSの管理コンソールからSQSにメッセージを登録する
    {"is_success": "true"}
    をメッセージに設定している場合はリトライせずに成功する。
    上記のメッセージを設定していない場合は30秒間隔で規定回数(4回)リトライされる。
    ※CloudWatchからログを確認できる。
