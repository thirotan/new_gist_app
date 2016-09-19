# gist app

# SETUP
```
  bundle install --path=vendor/bundle
  cp config.sample.yml config.yml #set db path
  RACK_ENV=development bundle exec rake db:migrate
```

# TEST
```
 bundle exec rake test
``` 

# start server(develop environment)
```
 RACK_ENV=development bundle exec shotgun config.ru &
```
