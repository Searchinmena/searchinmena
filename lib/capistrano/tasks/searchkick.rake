namespace :searchkick do
  desc "Reindex all"
  task :reindex do
    on roles(:app) do
      within fetch(:release_path) do
        system "bundle exec rake searchkick:reindex:all"
      end
    end
  end
end
