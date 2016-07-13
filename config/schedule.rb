set :output, "#{path}/log/cron.log"

every 1.day, at: '1:00 am' do
  rake 'delete_tmp_files'
end

every :friday, at: '3:00 am' do
  rake '-s sitemap:refresh'
end

every 2.day, at '12:00 am' do
  rake 'searchkick:reindex:all'
end