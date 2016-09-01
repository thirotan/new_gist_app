require 'sequel'

module SinatraApp
  class Model
    def db
      ENV['RACK_ENV']='development' unless ENV['RACL_ENV']
      config ||= YAML.load_file(settings.root+"config.yaml")
      db_config = ENV['RACK_ENV']
      dsn = config[db_config] 
      raise 'Missing db.dsn in configuration. Please set config.yml' unless dsn
      @db ||= Sequel.connect(dsn['dsn'])
    end
  end
end
