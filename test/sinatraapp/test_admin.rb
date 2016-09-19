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

  def test_unauthorized_admin_top
    authorize 'admin', 'nimda'
    get '/admin'
    assert_equal 401, last_response.status
  end

  def test_authorized_admin_top
    authorize 'admin', 'admin'
    get '/admin'
    assert_equal 200, last_response.status
  end

  def test_delete_entry
    entry = database.db[:entries].first(description: 'test paste')
    entry_id = entry[:entry_id]

    authorize 'admin', 'admin'
    post "/entry/#{entry_id}/delete"

    assert_equal 302, last_response.status
  end
end
