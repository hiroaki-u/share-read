# Share-read
<img width="1435" alt="github用トップ画" src="https://user-images.githubusercontent.com/65746218/103641220-c4c60d00-4f94-11eb-8c87-594d2ef81e95.png">


## :page_facing_up:概要
Share-readはビジネス本をアウトプットするwebアプリです。<br>
人に本の内容をshareすることで、本の知識を自分のものにすることを目的としています。

### 制作背景
社会人になってから、ビジネス本や自己啓発本を読むようになったのですが、本を読んだらそれで満足してしまっていました。<br>
そのため、せっかく読んだ本も内容もあまり覚えておりませんでした。

ある時アウトプット大全という本を読み、本のアウトプットの重要性を考えさせられました。<br>
そこで、本の内容をアウトプットするような読書会を開催することにしました。<br>
読んだ本をまとめて人に共有するという作業だけでも、これまでの読書と打って変わり、本の知識が頭に深く残っていました。<br>
さらに、業務中も本の知識を活かすことができるようになりました。

私のように本を読んで終わってしまっている方は、少なからずいらっしゃると思います。<br>
そのような方が本を読んだ時、より効果を発揮できるように本をアウトプットするアプリを制作しました。

### URL
https://share-read.jp

## :wrench:機能
- ユーザー関連
  - 新規登録機能 / 登録情報編集機能
  - ログイン機能 / ゲストログイン機能（ポートフォリオをご覧になる際は、こちらをご利用ください）
  - フォロー機能（ajaxの利用）
  - 通知機能

- 本関連
  - 本の検索機能（楽天APIの利用）
  - 本棚登録機能（ajaxの利用）
  - 楽天の購入ページへのリンク追加

- レビュー関連
  - レビュー投稿機能/レビュー編集機能
  - レビューの下書き機能
  - お気に入り機能(ajaxの利用)
  - コメント投稿・削除機能(ajaxの利用)
  - コメント編集機能

## :computer:操作
- 本の検索

![本の検索](https://user-images.githubusercontent.com/65746218/103730579-85e09780-5026-11eb-9012-070577db5e60.gif)

- レビューの投稿

![本のレビュー](https://user-images.githubusercontent.com/65746218/103730603-9133c300-5026-11eb-9e21-26dfc55e2ee0.gif)


## :open_file_folder:環境・使用技術
### フロントエンド
- Bootstarp 4.50
- HTML、CSS
- JavaScript、jQuery

### バックエンド
- Ruby 2.7.2
- Rails 6.0.3.4

### 開発環境
- Docker/Docker-compose

### 本番環境
- AWS(VPC、EC2、RDS for MySQL、S3、Cloudfront、ALB、 IAM、Route53）
- Nginx、puma
- Capistrano

### インフラ構成図 
インフラ構成図を記載

## :eyes:Anout me
Wantedly、Twitter、Qiitaをやっています。
よろしければご覧になってください。

Wantedly　https://www.wantedly.com/id/hiroaki_ueda_0329
Twitter　https://twitter.com/junie57576525
Qiita　https://qiita.com/Hiroaki_jr
