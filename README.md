# slack-bot

# API TOKEN の取得

- https://mwedremoteintern2017.slack.com/services/new/bot

# コード

```ruby
require 'dotenv/load'
require 'slack-ruby-client'

Slack.configure do |conf|
  conf.token = ENV['API_TOKEN']
end

p ENV['API_TOKEN']
client = Slack::RealTime::Client.new

client.on :hello do
  puts 'connected!'
end

client.on :message do |data|
  case data['text']
  when 'にゃーん' then
    client.message channel: data['channel'], text: ':cat:'
  end
end

client.start!

```

# 起動

```bash
$ ruby lib/bot.rb
```
