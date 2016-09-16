# frozen_string_literal: true
require 'simplecov'
require 'sequel'

ENV['RACK_ENV'] = 'test'

SimpleCov.start do
  add_filter '/test/'
end

require 'test/unit'
