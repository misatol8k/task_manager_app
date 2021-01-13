# README

*テーブルスキーマ

** user
|項番|カラム論理名|カラム物理名|型|
|:----|:----|:----|:----|
|1|ユーザーid|id|integer|
|2|名前|name|string|
|3|メールアドレス|email|string|
|4|パスワード|password_digest|string|

** task
|項番|カラム論理名|カラム物理名|型|
|:----|:----|:----|:----|
|1|タスクid|id|integer|
|2|タスク名|name|string|
|3|終了期限|end_date|date|
|4|優先順位|priority|string|
|5|ステータス|status|string|
|7|内容|content|text|
|8|ユーザーid|user_id|integer|

** label
|項番|カラム論理名|カラム物理名|型|
|:----|:----|:----|:----|
|1|ラベルid|id|integer|
|2|ラベル|label|string|
|3|ユーザーid|user_id|integer|
|4|タスクid|task_id|integer|
