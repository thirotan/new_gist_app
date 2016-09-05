require 'sinatra/base'
require 'sinatra/contrib'
require 'erubis'

require 'digest/sha1'
require 'time'

require 'sinatraapp/model'


module SinatraApp
  class Application < Sinatra::Base
    configure do
      set :root, File.dirname(__FILE__) + '/../../'
      set :erb, escape_html: true
      enable :logging
      file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file
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
      description = params[:description]
      content = params[:content]

      created_at = Time.now
      entry_id = Digest::SHA1.hexdigest("#{created_at}");

      database.db[:contents].insert(entry_id: entry_id, content: content, created_at: created_at, description: description)

      redirect to("/entry/#{entry_id}")
    end

    get '/entry/:entry_id' do
      @entry = database.db[:contents].first(entry_id: params[:entry_id])
      erb :entry
    end
  end
end
