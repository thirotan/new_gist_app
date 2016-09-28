# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'logger'
require 'rack/test'
require 'yaml'

require 'sinatraapp/app'
require 'sinatraapp/model'

module SinatraApp
  class Test < Test::Unit::TestCase
    
    CONFIG ||= YAML.load_file(File.dirname(__FILE__) + '/../../config.yml')
    def setup
      @app ||= SinatraApp::Application
      @database ||= SinatraApp::Model.new

      @admin_user = CONFIG['admin']['user']
      @admin_pass = CONFIG['admin']['pass']
      @admin_bad_pass = 'ngpass'
    end
  end
end
