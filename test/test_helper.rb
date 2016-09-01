require 'simplecov'
require sequel

config ||= YAML.load_file(settings.root+"config.yaml")
db_config = ENV['RACK_ENV']
dsn = config[db_config] 

DB = Sequel.connect(dsn)

SimpleCov.start do
  add_filter '/test/'
end

require 'test/unit'
