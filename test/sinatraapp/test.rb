# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'logger'
require 'rack/test'
require 'webmock/test_unit'

require 'sinatraapp/app'

module SinatraApp
  class Test < Test::Unit::TestCase
    def setup
      @app = SinatraApp::Application
    end
  end
end
