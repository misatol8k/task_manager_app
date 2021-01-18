# README

## Install
*Clone the repository*

```
git clone git@github.com:misatol8k/task_manager_app.git
cd project
```

*Check your Ruby version*

```
ruby -v
```

The ouput should start with something like ruby 5.2.4
If not, install the right ruby version using rbenv (it could take a while):

```
rbenv install 5.2.4
```

*Install dependencies*
Using Bundler

*Initialize the database*

```
rails db:create db:migrate
```

## Gems

```
ruby '2.6.5'
gem 'rails', '~> 5.2.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
```

## Serve

```
rails s
```

## Deploy
Push to Heroku

```
heroku create --remote heroku-18 --stack heroku-18
git push heroku-18 master
heroku run rails db:migrate
```

## テーブルスキーマ

### user

|項番|カラム論理名|カラム物理名|型|
|:----|:----|:----|:----|
|1|ユーザーid|id|integer|
|2|名前|name|string|
|3|メールアドレス|email|string|
|4|パスワード|password_digest|string|

### task

|項番|カラム論理名|カラム物理名|型|
|:----|:----|:----|:----|
|1|タスクid|id|integer|
|2|タスク名|name|string|
|3|終了期限|end_date|date|
|4|優先順位|priority|string|
|5|ステータス|status|string|
|7|内容|content|text|
|8|ユーザーid|user_id|integer|

### label

|項番|カラム論理名|カラム物理名|型|
|:----|:----|:----|:----|
|1|ラベルid|id|integer|
|2|ラベル|label|string|
|3|ユーザーid|user_id|integer|
|4|タスクid|task_id|integer|
