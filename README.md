# slack-bot

# Slack API TOKEN の取得

- https://mwedremoteintern2017.slack.com/services/new/bot

# コード

```ruby
require 'dotenv/load'
require 'slack-ruby-client'

Slack.configure do |conf|
  conf.token = ENV['API_TOKEN']
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|

  case data.text
  when 'にゃーん' then
    client.message channel: data['channel'], text: 'にゃーん :cat:'
  when 'ねこ' then
    client.message channel: data['channel'], text: 'https://farm6.staticflickr.com/5702/30703936136_c53433acff_z_d.jpg'
  when 'こんにちは' then
    client.message channel: data['channel'], text: "<@#{data.user}>さん、こんにちは"
  when /^<@#{client.self.id}> こんにちは/ then
    client.message channel: data['channel'], text: "<@#{client.self.name}> デス。<@#{data.user}>さん、こんにちは"
  when /^<@#{client.self.id}>/ then
    message = %w(大吉 中吉 小吉).sample
    client.message channel: data['channel'], text: "<@#{client.self.name}> デス。<@#{data.user}>さん、今日は #{message} です"
  end
end

client.start!

```

## MySQL を用意する

### インストール

```
brew install mysql
```

### セットアップ

```
mysql.server start
mysql_secure_installation
```

## Sequel Pro を用意する

- MySQL の中身を見るための GUI ツール
- 無料。Mac で使える。
- https://www.sequelpro.com/

### DB を作る

ここでは「slackbot」にしてある

## bundle install

```
bundle install
```

## テーブルを作る

### サンプル（book）

- テーブル名は 複数形 の名詞

```ruby
require 'dotenv/load'
require 'active_record'
require 'yaml'
require 'erb'

db_conf = YAML.load( ERB.new( File.read("./config/database.yml") ).result )

ActiveRecord::Base.establish_connection(db_conf["development"])
ActiveRecord::Migration.create_table :books do |t|
  t.string :title
  t.integer :price
  t.date :release_date
  t.timestamps
end
```

### 実行

```
ruby db/book.rb
```

## モデルを作る

- データーベースにアクセスして、データを取り出したり、保存したりします

```ruby
class Book < ActiveRecord::Base
end
```

## データを保存する

- インスタンスを作り（ `Book.new` ）、値を設定します
- インスタンス.save することでデータは保存できます

```ruby
book = Book.new
book.title = "タイトルです"
book.release_date = Date.today
book.save
```

## データを取り出す

- モデル.all で全部取得することができます

```ruby
books = Book.all
```

# 起動

```bash
$ ruby bot.rb
```
