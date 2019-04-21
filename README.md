# Piita

初めての自作ポートフォリオとして、プログラマのための技術共有サービス「Qiita」のコピーサイトを作成しました。  
仮アカウント  
email: sample@sample.com
pass: sample  

開発環境 ruby/Ruby on Rails/javascript/MySQL/AWS/EC2

## 機能一覧

- markdownによる記事投稿・編集(redcarpet)
- コードのシンタックスハイライト(rouge)
- 記事作成時のリアルタイムプレビュー(vue.js/marked.js)
- コメント投稿
- いいね
- お気に入り(ストック)登録
- ユーザー登録・編集・認証(devise)
- アバター画像アップロード(carrierwave)
- ページネーション(kaminari)

## 苦労した点

- デプロイ  
アプリの土台が完成した時点では問題なくherokuでデプロイをすることができたが、久しぶりにgit pushを試みたところ、ssh接続ができなくっていた。sshのキー再設定で直るという記事を見つけ、実践するも直らず。github公式ページでsshキーの作成方法を参照すると、macOSの比較的新しいバージョンでは、ssh作成時に設定ファイルを修正しなければならないとのこと。これで上手くいきgit pushでリモートと同期することは可能になった。しかし、herokuでサーバーを立ち上げるもエラー。ログを確認するとsocketファイルがtmpディレクトリになく、mysqlに接続できないとのこと。該当のファイルを作成すれば直るという記事を見て試してみるも変化せず。そこでtmpディレクトリ下位はデフォルトでgithubに同期されていないことに気づき、同期させるためにgitignoreから外して改めてサーバーを立ち上げる。しかし変化は見られなかった。調べても解決策を見いだせず途方に暮れ、デプロイ先をawsに変更することに。サーバーの構築から、必要なツールやソフトのインストール、設定等herokuに比べて手間は掛かったがデプロイに成功する。しかしその後も、cssが上手く適用されていないだとか、swap領域がなくプロセス起動に失敗するだとか問題はあったが、ネットで調べることで解決に至ることができた。

## DB設計

### users table

|Column|Type|
|------|----|
|user_name|string|
|email|string|
|avatar|string|

#### Association
- has_one_attached :avatar
- has_many :posts
- has_many :comments
- has_many :stocks
- has_many :likes

### posts table

Column|Type|
|------|----|
|title|string|
|body|text|
|user_id|integer|

#### Association
- belongs_to :user
- has_many :comments
- has_many :stocks
- has_many :likes

### comments table

Column|Type|
|------|----|
|text|text|
|user_id|integer|
|post_id|integer|

#### Association
- belongs_to :user
- belongs_to :post

### likes table

Column|Type|
|------|----|
|user_id|integer|
|post_id|integer|

#### Association
- belongs_to :user
- belongs_to :post

### stocks table

Column|Type|
|------|----|
|user_id|integer|
|post_id|integer|

#### Association
- belongs_to :user
- belongs_to :post

