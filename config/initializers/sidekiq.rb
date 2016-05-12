require 'sidekiq/web'
# config/initializers/sidekiq.rb

# Perform Sidekiq jobs immediately in development,
# so you don't have to run a separate process.
# You'll also benefit from code reloading.
if Rails.env.test?
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [A9n.sidekiq[:username], A9n.sidekiq[:password]]
end unless Rails.env.development? || Rails.env.test?
