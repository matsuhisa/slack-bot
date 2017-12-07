require 'active_record'
require 'yaml'
require 'erb'
require 'dotenv/load'
require './models/book.rb'

db_conf = YAML.load( ERB.new( File.read("./config/database.yml") ).result )
ActiveRecord::Base.establish_connection(db_conf["development"])

books = Book.all
puts "----------"
books.each do |book|
  puts book.title
  puts book.price
  puts book.release_date
end
puts "----------"

# 条件を決めて
# books = Book.where("release_date >= ?", '2017-12-01').where("release_date <= ?", '2017-12-07')
books = Book.where("release_date >= ? and release_date <= ?", '2017-12-01', '2017-12-07')
puts "----------"
books.each do |book|
  puts book.title
  puts book.price
  puts book.release_date
end
puts "合計：#{books.sum(:price)}"
puts "----------"
