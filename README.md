# WearingConnect

今自分が持っている洋服やファッション小物　<br>
欲しい洋服やファッション小物などを気軽に投稿してシェアするアプリです<br>
投稿したアイテムでコーディネートを組むことができます<br>
開発環境と本番環境にはDocker　インフラにはAWSを用いて独自ドメイン化しています.
CircleCIを使用してCI/CDパイプラインを構築しています





## 制作背景

洋服を見たりお洒落をして街に出かけることが好きなので自分が気に入った洋服などを保存して共有できるアプリがあればいいと思い、制作しました

## URL
<img width="2551" alt="preview" src="https://user-images.githubusercontent.com/49392147/92884363-bdf71580-f44c-11ea-86ee-1b0b5262304b.png">

http://www.wearing-connect.com <br>

- ログイン画面の「かんたんログイン」をクリックすると、メールアドレスとパスワードを入力せずにログインできます。<br>
- メールアドレス"`riku@example.com`"、パスワード"`password`"で【管理者】としてログインできます。<br>
- 【管理者】は、他の一般ユーザーのアカウントやアイテム、コーディネートを削除できる権限を持ちます。<br>
- レスポンシブ対応しているので、スマホ、タブレットからでもご覧いただけます。
- フォントの都合上　ChromeよりSafariで見ることをお勧めします。

## 使用技術
- Ruby 2.6.5, Rails 6.0.3.2
- MySQL 5.7
- Nginx, Puma
- AWS（VPC, EC2, Route 53）
- Docker/docker-compose
- CircleCI (CI/CDパイプラインを構築)
- RSpec
- Sass, Bootstrap, jQuery

## AWS構成図




<img width="1164" alt="AWS" src="https://user-images.githubusercontent.com/49392147/92549841-33b88100-f295-11ea-8f79-c9f2f6844726.png">

## 機能一覧
- ユーザー機能
  - deviseを使用
  - 新規登録、ログイン、ログアウト機能
  - マイページ、登録情報編集機能
- アイテム関係
  - アイテム一覧表示、アイテム詳細表示、アイテム投稿、アイテム編集、アイテム削除機能
  - 画像のアップロードはcarrierwaveを使用
- コーディネート関係
  - コーディネート表示、コーディネート投稿、コーディネート削除機能
- いいね機能
  - 登録したいいねの一覧表示
  - Ajaxを使用
- フォロー機能
  - フォロー、フォロワー一覧表示機能
  - Ajaxを使用
- 検索機能(RakutenAPI)
  - 楽天市場にある商品を検索して保存することが可能
- 管理ユーザー機能
  - ユーザー一覧の表示、一般ユーザーのアカウントやアイテム、コーディネートを削除可能
- Rspecによる自動テスト機能
  - 単体テスト機能
  - 統合テスト機能
  
- 将来的に追加したい機能、使用したい技術
  - Reactを用いてViewを書き換えようと考えています
  - AWSの各種サービス

##ダイアグラム

<img width="1128" alt="ダイアグラム" src="https://user-images.githubusercontent.com/49392147/92549702-de7c6f80-f294-11ea-8ce0-c068be2e3172.png">