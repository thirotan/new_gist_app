# frozen_string_literal: true
require 'sinatraapp/test'

class TestApplication < SinatraApp::Test
  include Rack::Test::Methods

  def app
    @app
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
    entry = @database.find_by_description(description: 'test paste')
    entry_id = entry.entry_id
    get "/entry/#{entry_id}"
    assert_equal 200, last_response.status
    assert last_response.body.include?('test post message')
  end

  def test_entry_raw_page
    entry = @database.find_by_description(description: 'test paste')
    entry_id = entry.entry_id
    get "/entry/#{entry_id}/raw"
    assert_equal 200, last_response.status
    assert last_response.body.include?('test post message')
  end

  def test_not_authorized_admin_top
    authorize @admin_user, @admin_bad_pass
    get '/admin'
    assert_equal 401, last_response.status
  end

  def test_authorized_admin_top
    authorize @admin_user, @admin_pass
    get '/admin'
    assert_equal 200, last_response.status
  end

  def test_create_entry
    post '/add_entry',
	'description' => 'test title ',
	'entry' => 'test body'
    assert_equal 302, last_response.status
  end

  def test_delete_entry
    entry = @database.find_by_description(description: 'test paste')
    entry_id = entry.entry_id

    authorize @admin_user, @admin_pass
    post "/entry/#{entry_id}/delete"

    assert_equal 302, last_response.status
  end
end
