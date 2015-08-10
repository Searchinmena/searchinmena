desc 'Remove tmp upload files'
task :delete_tmp_files do
  sh 'find ./public/uploads/tmp/* -mtime +1 -delete'
end
