namespace :elasticsearch do
  desc "Install elasticsearch"
  task :install do
    on roles(:app) do
      execute "apt-get update"
      execute "apt-get install openjdk-7-jre-headless -y"
      execute "cd /tmp"
      execute "wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-2.3.2.deb"
      execute "dpkg -i elasticsearch-2.3.2.deb"
      qq
      execute "mkdir es_servicewrapper"
      execute "curl -L http://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master | tar -xz -C es_servicewrapper --strip-components 1"
      execute "mv es_servicewrapper/service /usr/local/share/elasticsearch/bin/"
      execute "rm -Rf es_servicewrapper"
      execute "/usr/local/share/elasticsearch/bin/service/elasticsearch install"
      execute "ln -s `readlink -f /usr/local/share/elasticsearch/bin/service/elasticsearch` /usr/local/bin/rcelasticsearch"
    end
  end
end
