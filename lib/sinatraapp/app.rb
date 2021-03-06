# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/contrib'
require 'erubis'

require 'sinatraapp/model'

require 'digest/sha1'
require 'time'

module SinatraApp
  class Application < Sinatra::Base
    configure do
      set :root, File.dirname(__FILE__) + '/../../'
      set :erb, escape_html: true
      set :public_folder, File.dirname(__FILE__) + '/../../public'
      enable :logging
      file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file
    end

    helpers do
      def h(text:)
        Rack::Utils.escape_html(text)
      end

      def protected!
        return if authorized?
        headers['WWW-Authenticate'] = 'Basic ream="Restricted Area"'
        halt 401, "Not Authorized\n"
      end

      def authorized?
        @auth ||= Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [admin[:user], admin[:pass]]
      end
    end

    def admin
      config ||= YAML.load_file(File.dirname(__FILE__) + '/../../config.yml')
      admin ||= {user: config['admin']['user'], pass: config['admin']['pass']}
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
      entry = params[:entry]
      created_at = Time.now
      entry_id = Digest::SHA1.hexdigest(created_at.to_s)
      database.insert(entry_id: entry_id, description: description, entry: entry, created_at: created_at)
      redirect to("/entry/#{entry_id}")
    end

    get '/entry/:entry_id' do
      @entry = database.find(entry_id: params[:entry_id])
      error 404 unless @entry
      erb :entry
    end

    get '/entry/:entry_id/raw' do
      @entry = database.find(entry_id: params[:entry_id])
      error 404 unless @entry
      content_type 'text/plain'
      @entry.entry
    end

    get '/admin' do
      protected!
      @entries = database.all
      erb :admin
    end

    post '/entry/:entry_id/delete' do
      protected!
      entry_id = params[:entry_id]
      database.delete(entry_id: entry_id)
      redirect to('/')
    end
  end
end
