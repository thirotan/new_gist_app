# gist app

# SETUP
```
  bundle install --path=vendor/bundle
  DATABASE_URL=sqlte://db.sqlite bundle exec rake db:migrate
```

# TEST
```
 bundle exec rake test
``` 

# DEBUG
```
 ENV['RACK_ENV'] = 'development' bundle exec rackup
```
