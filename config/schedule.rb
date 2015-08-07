set :output, "#{path}/log/cron.log"

every 1.days, at: '1.15 PM' do
  rake 'delete_tmp_files'
end
