# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'logger'
require 'rack/test'
require 'webmock/test_unit'

require 'sinatraapp/app'
require 'sinatraapp/model'

module SinatraApp
  class Test < Test::Unit::TestCase
    def setup
      @app = SinatraApp::Application
      @database = SinatraApp::Model.new
    end
  end
end
