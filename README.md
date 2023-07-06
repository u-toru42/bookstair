## サービス名

![BOOKSTAIR](https://user-images.githubusercontent.com/37538568/235348108-38f8046f-dc51-426e-8cb4-813770facd05.png)

## サービスURL [https://bookstair.com](https://bookstair.com/)

---
<br>

![Ruby](https://img.shields.io/badge/Ruby-v3.1.4-red)
![rails](https://img.shields.io/badge/Rails-v7.0.4-red)
![Tailwind CSS](https://img.shields.io/badge/Tailwind%20CSS-v3.2.7-blue)

## サービス概要

Google Cloud Languageで感情分析を行い、安心してコメントを投稿・閲覧できる、コンピュータ・IT書籍専門の本棚サービスです。

![投稿失敗例(「イライラする」が引っ掛かったようです)](https://gyazo.com/fa3aa655aa8a9372c2a8c49563dd5446)
![投稿成功例](https://gyazo.com/f0bec09b646ceb38eb3843b6dd590a49)
![チュートリアルも用意しています](https://gyazo.com/0c05fcca653c6e9cf402d25089ba9f6b)

## メインのターゲットユーザー

- 気になる技術書があり、強い言葉や過激な表現を使わないレビューを見たい人。
- Qiitaのトレンド情報で注目の言語の技術書を調べたい人。

## ユーザーが抱える課題

- Amazonや技術ブログの技術書のコメントで強い言葉や過激な表現が書かれていると、購入や開発の意欲が削がれてしまう。
- 個人で登録するタイプの本棚サービスはモチベーションを維持しづらい。

## 解決方法

- 共有本棚に書籍を登録し、技術や難易度、お気に入りのページや解説、引用を投稿できるサービスを作る。
- コメント投稿機能にGoogle Cloud Languageの感情分析を実装し、強い言葉や不適切な表現を弾くようにする。
- 書籍・本棚検索でQiita APIを使用し、トレンド言語やワードをオートコンプリートで表示するようにする。

## 使用技術
### バックエンド
 - Ruby 3.1.4
 - Rails 7.0.4
### フロントエンド
- JavaScript
- Tailwind CSS
- Bulma
### インフラ
- Fly.io
- Cloudflare
- Google Domains
- PostgreSQL
### API
- 楽天ブックス検索API
- SendGrid
- Qiita API
- Google Cloud Language

## 実装した機能

- ユーザー登録機能
- ログイン機能
- ゲストログイン機能
- 掲示板機能
- 本棚投稿機能
- 本棚検索機能
- 書籍登録機能
- 書籍検索機能
- 投稿機能
- 書籍詳細に書籍の購入リンク
- 共有本棚内検索機能(オートコンプリート機能付き)
- 書籍登録画面でのQiitaタグのオートコンプリート機能
- 投稿一覧機能
- 共有本棚の書籍のお気に入り機能(非同期通信)
- 一覧画面で投稿数表示
- 一覧画面で注目数(詳細ページアクセスカウント)表示
- 投稿のチュートリアル機能
- Natural Languageの感情分析の投稿のバリデーション

## 本リリース後に実装する機能
- パスワードリセット機能とSend Gridの連携
- メールアドレス変更機能
- パスワード変更機能

## 画面遷移図

[Figma](<https://www.figma.com/file/1SjZ7MiiANkYElYjA7tSHa/%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E5%90%8D%3ABookStair(%E4%BB%AE%E5%90%8D)?node-id=0%3A1&t=xrEuekoiAxH4J1AD-1>)

## ER 図

[ER 図](https://bit.ly/3iEtN3e)
