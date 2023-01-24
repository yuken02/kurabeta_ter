# 比べたter

<p align="center"><img src="https://github.com/yuken02/kurabeta_ter/blob/main/app/assets/images/logo1_n.png" alt="nagano_cake" title="nagano_cake_log" width="130" height="130" /></p>
http://kurabeta-ter.com/

## 概要

Twitterの投稿を検索しグラフとして表示できるSNS分析サイトです。

### サイトテーマ

Twitterに投稿されたツイートをワード検索し、指定期間内の検索ヒット数をグラフとして表示することができます。
検索したワードはタグを付けて保存でき、保存したワードはタグごとに１つのグラフで見比べることができます。
利用者が気になるキーワードを入力し、自分だけのトレンドのランキングが作れるようなサイトです。
例えばPHP・Ruby・Pythonなどを入力しそれらがどれだけ呟かれているかをグラフで見ることができます。

### テーマを選んだ理由

プログラミング言語をTwitterで調べる時にそれぞれの言語別で情報量の違いや、その時々のトレンドを調べた際にぱっと見で分かりづらいなと感じていました。
比べたいワードを折れ線グラフでその推移を表示できるようになれば見やすく便利だなと思いこのテーマを選びました。

似たサービスにYahoo!検索のリアルタイム検索などがありますが、このサイトでは複数のワードを1つのグラフで見比べることができます。

### ターゲットユーザー

Twitterのキーワードを見比べたい人

### 主な利用シーン

気になるワードの投稿数を比較する時

## 設計書

- [ER図](https://drive.google.com/file/d/1aiUKImBytDS4G_pZ1Wb5oBGAghHjXhAD/view?usp=sharing)

- [テーブル定義書](https://drive.google.com/file/d/1e-welKeKK3NShVfg5Oh_iihRbmI_sl_8/view?usp=sharing)

- [アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1MpVwpQTHs5tbNy4qejv3PP5XV6Qio3g_PrfrKMANtH0/edit?usp=sharing)

## 開発環境

- Ruby 3.1.2
- Rails 6.1.7

## 使用Gem

- twitter
- dotenv-rails
- device
- omniauth-twitter
- omniauth-rails_csrf_protection
- mysql2
- devise-i18n
- devise-i18n-views
- net-smtp
- net-pop
- net-imap
- pry-byebug
- pry-rails
