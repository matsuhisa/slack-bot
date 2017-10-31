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
  when 'time' then
    client.message channel: data['channel'], text: "#{Time.now}"
  when 'こんにちは' then
    client.message channel: data['channel'], text: "<@#{data.user}>さん、こんにちは"
  when /^<@#{client.self.id}> こんにちは/ then
    client.message channel: data['channel'], text: "<@#{client.self.name}> デス。<@#{data.user}>さん、こんにちは"
  when /^<@#{client.self.id}>/ then
    message = %w(大吉 中吉 小吉).sample
    client.message channel: data['channel'], text: "<@#{client.self.name}> デス。<@#{data.user}>さん、#{message} です"
  end
end

client.start!
