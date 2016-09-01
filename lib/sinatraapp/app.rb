require 'sinatra/base'
require 'sinatra/contrib'
require 'erubis'
require 'sequel'

require 'sinatraapp/model'


module SinatraApp
  class Application < Sinatra::Base
    configure do
      set :root, File.dirname(__FILE__) + '/../../'
      set :erb, escape_html: true
    end
   
    helpers do
      def h(text)
        Rack::Utils.escape_html(text)
      end
    end
 
    not_found do 
      status 404
      erb :error_404
    end
    
    get '/' do
      erb :index
    end

    post '/add' do
      erb :index
    end

    get '/entry/:id' do
      erb :entry
    end
  end
end
