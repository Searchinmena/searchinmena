namespace :searchkick do
  desc "Reindex all"
  task :reindex do
    on roles(:app) do
      execute :rake, "searchkick:reindex:all"
    end
  end
end

