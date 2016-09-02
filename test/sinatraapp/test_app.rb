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
         'name' => 'test_user',
         'content' => 'test post message'

    assert_equal 302, last_response.status
  end

  def test_entry_page
    entry_id = 1
    get "/entry/#{entry_id}"
    assert_equal 200, last_response.status
  end
end
