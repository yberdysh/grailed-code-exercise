require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/grailed-exercise.sqlite3"
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

require_all 'app'
