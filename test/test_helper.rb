require 'simplecov'
require 'sequel'
require 'yaml'

ENV['RACK_ENV'] = 'test'

SimpleCov.start do
  add_filter '/test/'
end

require 'test/unit'
