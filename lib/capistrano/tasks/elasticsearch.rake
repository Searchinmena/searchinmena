namespace :elasticsearch do
  desc "Install elasticsearch"
  task :install do
    on roles(:app) do
      execute "sudo apt-get update"
      execute "sudo apt-get install openjdk-7-jre-headless -y"
      execute "cd /tmp"
      execute "wget https://download.elasticsearch.org/elasticsearch\
/elasticsearch/elasticsearch-2.3.2.deb"
      execute "sudo dpkg -i elasticsearch-2.3.2.deb"
    end
  end
end

namespace :elasticsearch do
  desc "start elasticsearch"
  task :start do
    on roles(:app) do
      execute "sudo service elasticsearch start"
    end
  end
end

namespace :elasticsearch do
  desc "restart elasticsearch"
  task :restart do
    on roles(:app) do
      execute "sudo service elasticsearch restart"
    end
  end
end
