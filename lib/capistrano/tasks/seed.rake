namespace :db do
  desc "reload the database with seed data"
  task :seed do
    on roles(:app) do
      within fetch(:release_path) do
        execute :rake, "db:seed"
      end
    end
  end
end
