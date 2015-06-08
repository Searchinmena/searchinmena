namespace :bower do
  desc "bower install"
  task :install do
    on roles(:app) do
      within release_path do
        execute :npm, 'install'
        execute :rake, 'bower:install CI=true'
      end
    end
  end
end
