# gist app

# SETUP
```
  bundle install --path=vendor/bundle
  RACK_ENV=development bundle exec rake db:migrate
```

# TEST
```
 bundle exec rake test
``` 

# startt server(develop envronment)
```
 RACK_ENV=development bundle exec shotgun config.ru &
```
