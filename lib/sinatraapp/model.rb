require 'sequel'

module SinatraApp
  class Model
    def db
      ENV['RACK_ENV']='development' unless ENV['RACK_ENV']
      config ||= YAML.load_file(settings.root+"config.yaml")
      db_config = ENV['RACK_ENV']
      dsn = config[db_config]['dsn']
      raise 'Missing db.dsn in configuration. Please set config.yml' unless dsn
      @db ||= Sequel.connect(dsn)
    end
  end
end
