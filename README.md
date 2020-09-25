# Delitable

## URL
http://delitable.work/
[![image](https://user-images.githubusercontent.com/62997834/92128993-efb12080-ee3d-11ea-8e33-bba828f2b3f4.png)](http://delitable.work/)


## 概要
* 野菜の購入・配送と、それらの野菜を使った料理レシピの投稿・共有ができるポートフォリオです。
* 作りたい料理に必要な野菜を購入したり、逆に興味のある野菜を使った料理調べて作ったりと、  
日々の料理をサポートできるようなサービスです。

### テーマ
* 自分もよく使うamazonのようなECサイト、クックパッドのようなレシピのSNSサイトは多くありますが、  
2個両立したものがあれば便利かと考え野菜の配送＋レシピの投稿の、2つの主な機能を持ったものを  
作成しました。  

* サイト名の意味は　Delivery, Delicious, vegetable, tableの4つを掛け合わせ、  
「美味しい野菜を食卓へ届ける」がテーマです。


### テーマを選んだ理由
* 料理が好きで現在実家にて家族の晩ご飯の用意を担当しているのですが、  
食品の半分以上が毎週配送で来ており自分ではなかなか買わなかったり  
季節が感じられる野菜が入っているため色々なバリエーションの料理を作れるのが楽しく思っています。

- ただ、毎回調べて作ったり自分でレシピを考えるのではなく、届く食材と合ったレシピが  
発見できたり、時には共有できればもっと料理するのが楽しくなるのではと思いテーマに選びました。  

- この学習期間で身に付けたECサイトとSNSサイトを作るスキルを合わせたものを作りたかったので、  
レシピ投稿＋野菜の配送の2つの機能を持ったポートフォリオを作成しました。


### ターゲットユーザ
* 料理をあまりしない一人暮らし
* いつも同じ野菜やレシピが多くバリエーションを増やしたい人
* 作る量が多く、食材の買い出しが大変な家庭


### 主な利用シーン
* 食べたいレシピを探したり、レシピにある野菜や興味のあるものを注文して、料理を楽しめます。

## 機能・技術
- HTML/CSS
	- Bootstrap
	- SCSS
	- レスポンシブ対応

- Ruby on Rails
	- コードフォーマット：rubocop
	- テスト：RSpec
	- デバッグ：pry-byebug
	- 検索：ransack
	- タグ付け：acts-as-taggable-on
	- トラッキング：impressionist
	- データ順の入れ替え：acts_as_list
	- クレジット決済機能：payjp(テストモード)
	- ユーザー認証：devise
	- 買い物かご
	- レビュー
	- 画像アップロード
	- 画像プレビュー表示
	- おすすめ、ランキング表示
	- フォロー
	- いいね
	- コメント
	- CRUD処理

- JavaScript
	- 非同期通信 ：ajax
	- 星評価：raty.js
	- 郵便番号から住所自動入力：jpostal.js

- AI
	- 自然言語処理：Natural Language API

## 環境
- フロントエンド
	- Bootstrap 4.4.1
	- SCSS
	- JavaScript、jQuery

- バックエンド
	- Ruby 2.5.7
	- Rails 5.2.4.3

- 開発環境
	- Vagrant 2.2.4

- 本番環境
	- MySQL2
	- AWS (EC2、RDS for MySQL、Route53)
	- Nginx、 Puma
	- Capistrano

- 構成図
![image](https://user-images.githubusercontent.com/62997834/93009715-37167a00-f5bf-11ea-9a0b-3b69a42fbc0d.png)

## 設計

- 設計書
	- アプリケーション詳細設定：https://www.icloud.com/numbers/0MUDr2Jb7IqNjydIzylYOACsg
	- テーブル定義書：https://www.icloud.com/numbers/0nfYRItc2tWXCYZR2jlyc7jDw
	- ER図：https://drive.google.com/file/d/1sncP0fHAl0r4UybR3iU1nNUXEbx8t7nz/view?usp=sharing

- 機能一覧
	- https://docs.google.com/spreadsheets/d/1IJ4RoAs_-xBsC-Z0b_gmG4WTZG94Oju5-hKZHIRKyz4/edit#gid=0

