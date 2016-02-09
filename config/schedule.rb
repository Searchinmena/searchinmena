set :output, "#{path}/log/cron.log"

every 1.days, at: '1 AM' do
  rake 'delete_tmp_files'
end
every 1.day, at: '5:00 AM' do
  rake "-s sitemap:refresh"
end

every 2.minutes do
  rake "-s sitemap:refresh"
  Rails.logger.debug "sitemap update successfully"
end