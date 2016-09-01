require 'simplecov'
require 'sequel'
require 'yaml'

ENV['RACK_ENV'] = 'test'

config ||= YAML.load_file(File.dirname(__FILE__)+"/../config.yml")
db_config = ENV['RACK_ENV']

dsn = config[db_config] 

DB = Sequel.connect(dsn['dsn'])

SimpleCov.start do
  add_filter '/test/'
end

require 'test/unit'
