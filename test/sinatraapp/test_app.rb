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

  def test_top
    get '/'
    assert_equal 200, last_response.status
  end

  def test_add
    post '/add_entry',
         'description' => 'test paste',
         'entry' => 'test post message',
         'created_at' => '2016-09-02 15:27:11 +0900'

    assert_equal 302, last_response.status
  end

  def test_entry_page
    entry = database.db[:entries].first(description: 'test paste')
    entry_id = entry[:entry_id]
    get "/entry/#{entry_id}"
    assert_equal 200, last_response.status
    assert last_response.body.include?('test post message')
  end

  def test_entry_raw_page
    entry = database.db[:entries].first(description: 'test paste')
    entry_id = entry[:entry_id]
    get "/entry/#{entry_id}/raw"
    assert_equal 200, last_response.status
    assert last_response.body.include?('test post message')
  end
end
