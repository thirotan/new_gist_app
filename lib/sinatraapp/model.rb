# frozen_string_literal: true

require 'sequel'
require 'sinatraapp/entries'

module SinatraApp
  class Model
    def initialize
      db
    end

    def db
      return Thread.current[:application_db] if Thread.current[:application_db]
      ENV['RACK_ENV'] = 'development' unless ENV['RACK_ENV']
      config ||= YAML.load_file(File.dirname(__FILE__) + '/../../config.yml')
      db_config = ENV['RACK_ENV']
      dsn = config[db_config]['dsn']
      raise 'Missing db.dsn in configuration. Please set config.yml' unless dsn
      client = Sequel.connect(dsn)
      Thread.current[:application_db] = client
      client
    end

    def insert(entry_id:, description:, entry:, created_at:)
      db[:entries].insert(entry_id: entry_id, entry: entry, created_at: created_at, description: description)
    end

    def find(entry_id:)
      db[:entries].where(entry_id: entry_id).map do |e|
        SinatraApp::Entries.new(e)
      end.first
    end

    def find_by_description(description:)
      db[:entries].where(description: description).map do |e|
        SinatraApp::Entries.new(e)
      end.first
    end

    def all
      db[:entries].order(Sequel.desc(:created_at)).map do |e|
        SinatraApp::Entries.new(e)
      end
    end

    def delete(entry_id:)
      db[:entries].where(entry_id: entry_id).delete
    end
  end
end
