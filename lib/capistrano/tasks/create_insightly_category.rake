namespace :insightly do
  desc "create category in insightly for first time setup"
  task :create_category do
    on roles(:app) do
      within fetch(:release_path) do
        execute :rake, "create_insightly_category"
      end
    end
  end
end
