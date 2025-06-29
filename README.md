# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## 開発環境
- OS: macOS Big Sur 11.6.7
- Ruby: Ruby 2.6.5
- Rails: Rails 6.0.6
- データベース: MySQL 5.5.8
- 開発環境のツール: VSCode

  このアプリケーションは、macOS Big Sur 11.6.7上で開発され、Ruby 2.6.5およびRails 6.0.6を使用しています。データベースとしてMySQL 5.5.8が使用されています。

  開発環境のツールとしては、VSCodeを使用しています。必要に応じて、適切なバージョンのソフトウェアをインストールしてください。

## インストール方法
 アプリケーションをインストールするための手順を記載することで、新規開発者や貢献者が環境を構築するのを容易にすることができます。
## テスト方法
 アプリケーションをテストするための手順や、テストに使用するツールの説明を記載することで、テストを実行する際に必要な情報を提供することができます。
## アプリケーションの概要
 アプリケーションの目的や機能の概要を記載することで、開発者以外の人がアプリケーションを理解しやすくなります。

## テーブル

### Questions テーブル

`questions` テーブルは、出題する問題に関する情報を格納します。

| 列名          | データ型    | 説明                         |
| ------------- | --------- | --------------------------- |
| id            | integer   | 問題のユニークなID           |
| text          | text      | 問題の内容                   |
| genre_id      | integer   | 関連するジャンルのID         |
| created_at    | datetime  | 作成日時                     |
| updated_at    | datetime  | 更新日時                     |
| image         | text      | 問題に関連する画像のURL        |
| priority_id   | integer   | 問題の優先度を表すID         |
| level_id      | integer   | 問題の難易度を表すID         |

### Choices テーブル

`choices` テーブルは、選択肢に関する情報を格納します。

| カラム名     | データ型       | 説明                 |
| ----------- | ------------ | -------------------- |
| id          | integer      | レコードの一意の識別子 |
| choice      | varchar(255) | 選択肢               |
| is_answer   | boolean      | 正解かどうかのフラグ  |
| question_id | int          | 関連する問題の識別子 |
| created_at  | datetime     | レコードの作成日時   |
| updated_at  | datetime     | レコードの更新日時   |
| commentary  | varchar(255) | 選択肢の解説        |

### Answers テーブル

`answers` テーブルは、解答に関する情報を格納します。


| 列名       | データ型    | 説明                |
| ---------- | --------- | ------------------ |
| id         | integer   | 解答のユニークなID  |
| answer     | text      | 解答の内容          |
| created_at | datetime  | 作成日時            |
| updated_at | datetime  | 更新日時            |
| question_id| integer   | 関連する質問のID    |

### Genres テーブル

`genres` テーブルは、出題範囲に関する情報を格納します。

| 列名       | データ型 | 説明               |
| ---------- | -------- | ----------------- |
| id         | integer  | ジャンルのID       |
| name       | string   | ジャンルの名称     |
| created_at | datetime | 作成日時           |
| updated_at | datetime | 更新日時           |


### Levels テーブル

`levels` テーブルは、難易度に関する情報を格納します。

| 列名       | データ型 | 説明               |
| ---------- | -------- | ----------------- |
| id         | integer  | 難易度のID         |
| name       | string   | 難易度の名称       |
| created_at | datetime | 作成日時           |
| updated_at | datetime | 更新日時           |


## ライセンス

- 使用するのは自由です。
- 配布は禁止です。
- 教育現場での使用は無料です。
- 二次利用したい場合は、開発者に事前に連絡することをお願いいたします。

<!--  -->