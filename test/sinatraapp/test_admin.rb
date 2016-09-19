# frozen_string_literal: true
require 'sinatraapp/test'

class TestApplication < SinatraApp::Test
  include Rack::Test::Methods

  def app
    @app
  end

  def database
    @database
  end

  def test_admin_top
    authorize 'admin', 'admin'
    get '/admin'
    assert_equal 200, last_response.status
  end
end
