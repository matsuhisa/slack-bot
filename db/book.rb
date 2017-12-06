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
