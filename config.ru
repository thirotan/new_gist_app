# frozen_string_literal: true
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib/')

require 'rack/urlmap'
require 'sinatraapp/app'
require 'rack/protection'

use Rack::Protection::XSSHeader
use Rack::Protection::FrameOptions


run SinatraApp::Application
