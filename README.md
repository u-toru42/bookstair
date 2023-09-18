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

- 投稿の失敗例:「イライラする」が投稿内容のバリデーションで止まりました。<br>
<a href="投稿失敗例(「イライラする」が引っ掛かったようです)"><img src="https://i.gyazo.com/fa3aa655aa8a9372c2a8c49563dd5446.gif" alt="Image from Gyazo" width="800"/></a>
- 投稿の成功例です。<br>
<a href="投稿成功例"><img src="https://i.gyazo.com/f0bec09b646ceb38eb3843b6dd590a49.gif" alt="Image from Gyazo" width="800"/></a><br>
- [intro.js](https://introjs.com/)で投稿のチュートリアルも用意しています。<br>
<a href="投稿のチュートリアルも用意しています。"><img src="https://i.gyazo.com/0c05fcca653c6e9cf402d25089ba9f6b.gif" alt="Image from Gyazo" width="800"/></a><br>

## メインのターゲットユーザー

- 気になる技術書があり、強い言葉や過激な表現を使わないレビューを見たい人。
- Qiitaのトレンド情報で注目の言語の技術書を調べたい人。

## ユーザーが抱える課題

- Amazonや技術ブログの技術書のコメントで強い言葉や過激な表現が書かれていると、購入や開発の意欲が削がれてしまう。
- 個人で登録するタイプの本棚サービスはモチベーションを維持しづらい。

## 解決方法

- 共有本棚に書籍を登録し、技術や難易度、お気に入りのページや解説、引用を投稿できるサービスを作る。
- コメント投稿機能にGoogle Cloud Languageの感情分析を実装し、強い言葉や不適切な表現を弾くようにする。
- 書籍・本棚検索でQiita APIを使用し、トレンド言語やワードをオートコンプリートで表示するようにする。<br>
- このように書籍登録・検索画面でQiita APIのトレンド情報を使い、オートコンプリートが動きます。
<a href="検索画面のオートコンプリート"><img src="https://i.gyazo.com/ea614eb2681f3578fb4259ed3202abb1.gif" alt="Image from Gyazo" width="800"/></a><br>
- 本棚画面ではHTML5とQiita APIを2重で処理したオートコンプリートを実装しています。<br>
<a href="本棚画面のオートコンプリート"><img src="https://i.gyazo.com/dcfe76d8b853acfa33024e9bc99cf987.gif" alt="Image from Gyazo" width="800"/></a><br>

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

## 画面遷移図

[Figma](<https://www.figma.com/file/1SjZ7MiiANkYElYjA7tSHa/%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E5%90%8D%3ABookStair(%E4%BB%AE%E5%90%8D)?node-id=0%3A1&t=xrEuekoiAxH4J1AD-1>)

## ER 図

[![ER図](https://mermaid.ink/img/pako:eNq9lkFv0zAUx79K5HM7dS2UNWeunLihSpGbvKVWE7s4Dqy0lUgLQhrjgjShiQOXgRBIbICEpoG0D5PRwbfATtImTbMwCboeqsT-v9_7236xPUQmswDpCPhtgm2O3TZtU03zPeCeNhpVq2yobeMHjBMBnqa30fnJ4_PT0zD4FE7fhdMf4eSb-g-Ofh0-m-0fq_Zgd3b8Kgw-_nz6Npzszl6fXHx-EU5eXhx8_733JQwOwsnzNlJJUu6YVaujkdZhrPdvSWZ7QRgcKvzKKBTcxfyKCWZP3symXxVxd__i_VnWdgoqsC2zq-jYTyFvyWHKyrk0BLYNDg4WhNEcPEZlZ2NyFk6OS83meIlz2SjZWgaeoK7mPHYtOaZDzJ63BFpMQQZ9FE4_hNOpfFDo4tUaqkdN8wQn1NbAxcSRWOo7ji4LxvEgHleqoCYf9AVYRh973kPGrVI5xS6UCjh4IBYsQ7Ae0FhgYQGCyPCcxAMqDCxWRC64HeCGyQEre3NFksdkdJtwN1qPwiyJIBOZ74pjl9IncJ-m0dEU5gELT8VzsRD6fatEOF4u4lyNJSvZITahIhWRSxYo0SnGZZI1-89bVgX5N7sq1iBehxarBOwIrQvYcgiFEkmHWYOS7j62IfNqdrGseJ5pkfje2uco_3EKIhxYasG-6LKsLw874BmKnzWLuQ0GceWgDJ87mR55GLhFTaYcr6yppVxRR58TE9Y68HhrKyjmklWXErCBz2Ovs5bTM_W_1_KaHN8nRGAjOomGK1t1bj6ZT8VazVxi45omBFWQC3JfJ5a8kUUu2kh05UHSRupsteQepZRKJ780dndATaQL7kMFxeTkDjdv7GN6j7HsK9KHaAfpjfrNjWar0Ww0mlutWr25eauCBkivjSvoURRQ22jFv2ardmNza7NRryCwiGD8TnxfjK6N4z9AMgKD?type=png)]([https://mermaid.live/edit#pako:eNq9lkFv0zAUx79K5HM7dS2UNWeunLihSpGbvKVWE7s4Dqy0lUgLQhrjgjShiQOXgRBIbICEpoG0D5PRwbfATtImTbMwCboeqsT-v9_7236xPUQmswDpCPhtgm2O3TZtU03zPeCeNhpVq2yobeMHjBMBnqa30fnJ4_PT0zD4FE7fhdMf4eSb-g-Ofh0-m-0fq_Zgd3b8Kgw-_nz6Npzszl6fXHx-EU5eXhx8_733JQwOwsnzNlJJUu6YVaujkdZhrPdvSWZ7QRgcKvzKKBTcxfyKCWZP3symXxVxd__i_VnWdgoqsC2zq-jYTyFvyWHKyrk0BLYNDg4WhNEcPEZlZ2NyFk6OS83meIlz2SjZWgaeoK7mPHYtOaZDzJ63BFpMQQZ9FE4_hNOpfFDo4tUaqkdN8wQn1NbAxcSRWOo7ji4LxvEgHleqoCYf9AVYRh973kPGrVI5xS6UCjh4IBYsQ7Ae0FhgYQGCyPCcxAMqDCxWRC64HeCGyQEre3NFksdkdJtwN1qPwiyJIBOZ74pjl9IncJ-m0dEU5gELT8VzsRD6fatEOF4u4lyNJSvZITahIhWRSxYo0SnGZZI1-89bVgX5N7sq1iBehxarBOwIrQvYcgiFEkmHWYOS7j62IfNqdrGseJ5pkfje2uco_3EKIhxYasG-6LKsLw874BmKnzWLuQ0GceWgDJ87mR55GLhFTaYcr6yppVxRR58TE9Y68HhrKyjmklWXErCBz2Ovs5bTM_W_1_KaHN8nRGAjOomGK1t1bj6ZT8VazVxi45omBFWQC3JfJ5a8kUUu2kh05UHSRupsteQepZRKJ780dndATaQL7kMFxeTkDjdv7GN6j7HsK9KHaAfpjfrNjWar0Ww0mlutWr25eauCBkivjSvoURRQ22jFv2ardmNza7NRryCwiGD8TnxfjK6N4z9AMgK](https://mermaid.ink/img/pako:eNq9lk9v0zAYxr9K5HM7Jf2zlpy5cuKGKkVu8q61mtjFcWClrURaENIYF6QJTRy4DIRAYgMkNA2kfZiMDr4FdpO1aZaFSdBdosR-_Hsfv35je4hs5gAyEfDbBHc49lq0RTUt8IH72mhULrOhtoUfME4E-JrZQmfHj89OTqLwUzR9F01_RJNv6hke_jp4Nts7Uu3hzuzoVRR-_Pn0bTTZmb0-Pv_8Ipq8PN___nv3SxTuR5PnLaSCLLljVi6PRlqbsd6_BZnthlF4oPCXZqHgHubXDDB78mY2_aqIO3vn70_TtpegHNsyuhod-8nlrThcsjIuLYE7FgcXC8JoBh6j0tmYnEaTo0KzGV7iXDZKtpaCJ6jrOY9dS47tErvnr4AWKUihD6Pph2g6lS8Knb9aQ_Wqab7ghHY08DBxJZYGrmvKgnF9iOe1VFCbD_oCHKuPff8h406hnGIPCgUcfBALliVYD2gscLAAQeTwjMQHKiwsLok88NrALZsDVvYuFEkcm9Etwr35euRGSQSpkdmueOxK-AQe0OXoeQqzgIWn_FwshEHfKRCOV4s4U2PJSrZJh1CxFJErFijRKcZVkjX7z1pWBfk3u2qsRfw2zVcJ2BZaF7DjEgoFkjZzBgXdfdyB1KfdxbLieapF4ntrz1H25xREuLDSggPRZWlfPnbBtxQ_bRbzDljEk5OyAu6meuRh4OU12XK-sqZWYs07-pzYsNaJx1tbTjEXrLqUQAf4xdibrOXlmfrfa3lNju8TIrA1P4mGl7bqTD5ZQMVazVxh44YSgkrIA7mvE0feyOYuWkh05UHSQupsdeQepZRKJ_80dndAbWQKHkAJxeTkDnfR2Mf0HmPpT2QO0TYyq7XmxmZFb9ZqtxpG1dCNagkNkFk2mhtGs3qrotf0ulHR9Up1XEKP5ghjw9isV_VmpdrQG_WmXm-UEDhEMH4nvkHOL5LjPzmRBeM?type=png)

