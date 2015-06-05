source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'pg'

# assets
gem 'sass-rails', '~> 5.0'
gem 'haml'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer'
gem 'bower-rails'

gem 'devise'
gem 'country_select'

gem 'a9n'
gem 'honeybadger', '~> 2.0'
gem 'mailcatcher'

gem 'dependor'

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.0'
  gem 'jasmine-rails'
  gem 'bogus'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
end

group :test do
  gem 'factory_girl'
  gem 'simplecov'
end

group :development do
  gem 'rubocop'
  gem 'haml-lint', require: false
end

group :production do
  gem 'unicorn'
end

group :development do
  gem 'capistrano', '~> 3.3'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
end

