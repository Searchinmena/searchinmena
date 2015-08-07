set :output, "#{path}/log/cron.log"

every 1.days, at: '12:15 AM' do
  rake 'delete_tmp_files'
end
