namespace :elasticsearch do
  desc "Install elasticsearch"
  task :install do
    on roles(:app) do
      run "#{sudo} apt-get update"
      run "#{sudo} apt-get install openjdk-7-jre-headless -y"
      run "cd /tmp"
      run "wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-2.3.2.deb"
      run "#{sudo} dpkg -i elasticsearch-2.3.2.deb"
      qq
      run "mkdir es_servicewrapper"
      run "curl -L http://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master | tar -xz -C es_servicewrapper --strip-components 1"
      run "#{sudo} mv es_servicewrapper/service /usr/local/share/elasticsearch/bin/"
      run "rm -Rf es_servicewrapper"
      run "#{sudo} /usr/local/share/elasticsearch/bin/service/elasticsearch install"
      run "#{sudo} ln -s `readlink -f /usr/local/share/elasticsearch/bin/service/elasticsearch` /usr/local/bin/rcelasticsearch"
    end
  end
end
