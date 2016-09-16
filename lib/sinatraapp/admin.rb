# frozen_string_literal: true
require 'sinatra/base'
require 'sinatra/contrib'
require 'erubis'

require 'sinatraapp/model'

module SinatraApp
  class Admin < Sinatra::Base
    configure do
      set :root, File.dirname(__FILE__) + '/../../'
      set :erb, escape_html: true
      enable :logging
      file = File.new("#{settings.root}/log/#{settings.environment}-admin.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file
    end

    helpers do
      def h(text:)
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
      entries = database.db[:entries].all
      erb :admin
    end

    post '/entry/#{entry_id}' do
      entry_id = params[entry_id]
      database.db[:entries].where(entry_id: entry_id).delete
    end
  end
end
