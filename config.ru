# frozen_string_literal: true
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib/')

require 'rack/urlmap'
require 'sinatraapp/app'
require 'sinatraapp/admin'
require 'rack/protection'

use Rack::Protection::XSSHeader
use Rack::Protection::FrameOptions


use Rack::Static, urls: ['/css'], root: File.join(File.dirname(__FILE__), 'public')

pass = SecureRandom.hex
puts "PASSWORD: #{pass}\n"


run Rack::URLMap.new(
  '/admin/' => Rack::Auth::Basic.new(SinatraApp::Admin) do |username, password|
    username == 'admin' && password == pass
  end,
  '/' => SinatraApp::Application
)
