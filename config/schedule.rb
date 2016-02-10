set :output, "#{path}/log/cron.log"

every 1.day, at: '1:00 am' do
  rake 'delete_tmp_files'
end

every 1.day, at: '3:00 am' do
  rake '-s sitemap:refresh'
end