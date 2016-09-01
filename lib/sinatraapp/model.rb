require 'sequel'

module SinatraApp
  class Model
    def db
      return @db if @db?
      config ||= YAML.load_file(settings.root+"config.yaml")
      db_config = ENV['RACK_ENV']
      dsn = config[db_config] 
      raise 'Missing db.dsn in configuration. Please set config.yml' unless dsn
      @db ||= Sequel.connect(dsn)
    end
  end
end
