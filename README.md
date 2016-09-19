# gist app

# SETUP
```
  bundle install --path=vendor/bundle
  cp config.sample.yml config.yml #and setup user & pass & db
  RACK_ENV=development bundle exec rake db:migrate
```

# TEST
```
 bundle exec rake test
``` 

# startt server(develop environment)
```
 RACK_ENV=development bundle exec shotgun config.ru &
```
