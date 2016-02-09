source 'https://rubygems.org'

gem 'rails', '4.2.3'
gem 'pg'
gem 'a9n'
gem 'honeybadger', '~> 2.0'
gem 'dependor'
gem 'devise'
gem 'omniauth-facebook'
gem 'whenever', require: false

# assets
gem 'sass-rails', '~> 5.0'
gem 'haml'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer'
gem 'bower-rails'
gem 'jquery-rails'
gem 'jquery-cookie-rails'
gem 'non-stupid-digest-assets'
gem 'angular-rails-templates', '~> 0.2.0'

gem 'mini_magick'
gem 'fog'
gem 'carrierwave'
gem 'carrierwave_backgrounder',
  git: 'git@github.com:lesniakania/carrierwave_backgrounder.git'
gem 'sidekiq'
gem 'sinatra', require: nil
gem 'sitemap_generator'

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
  gem 'timecop'
end

group :development do
  gem 'rubocop', git: 'git@github.com:bbatsov/rubocop.git'
  gem 'haml-lint', require: false
  gem 'mailcatcher'
  gem 'foreman'
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
