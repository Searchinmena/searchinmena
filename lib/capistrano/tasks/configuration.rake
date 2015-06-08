namespace :configuration do
  desc "Copy configuration.yml"
  task :copy do
    on roles(:app) do
      within fetch(:release_path) do
        execute :cp, "config/configuration.yml.#{fetch(:stage)}",
                     "config/configuration.yml"
      end
    end
  end
end
