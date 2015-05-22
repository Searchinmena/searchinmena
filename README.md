## SIM

Search in MENA

#### Project setup

```
cp config/database.yml.example config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate

npm install
bundle exec rake bower:install

bundle exec rails s
```

#### Running tests

##### Rspec (ruby unit tests)

```
bundle exec rspec spec
```

##### Jasmine (javascript tests)

```
npm run karma
```

##### Protractor (integration tests)

```
npm run protractor
```

