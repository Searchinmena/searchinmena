namespace :sidekiq do
  desc "Restarts sidekiq"
  task :restart do
    on roles(:app) do
      execute "/usr/local/bin/god restart sidekiq"
    end
  end
end

