namespace :db do
  desc "reload the database with seed data"
  task :seed do
    on roles(:app) do
      within fetch(:release_path) do
        execute "bundle exec rake db:seed RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end
end
