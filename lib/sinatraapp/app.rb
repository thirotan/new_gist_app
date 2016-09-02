require 'sinatra/base'
require 'sinatra/contrib'
require 'erubis'

require 'securerandom'
require 'Time'

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

    def database
      @database ||= SinatraApp::Model.new
    end
    
    get '/' do
      erb :index
    end

    post '/add_entry' do
      name = params[:name].empty? ? 'no name' : params[:name]
      content = params[:cotent]

      id = SecureRandom.hex
      created_at = Time.now

      database.db[:contents].insert(id: id, name: name, content: content, created_at: created_at)

      redirect :index
    end

    get '/entry/:id' do
      @entry = database.db[:contents].find(id: params[:id])
      erb :entry
    end
  end
end
