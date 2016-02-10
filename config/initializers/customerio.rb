# config/initializers/customerio.rb
Rails.configuration.customerio = {
  site_id: ENV['3823999354dd63de1f8d'],
  api_key: ENV['1a4d2164782635ea53b1']
}
@cio = Customerio::Client.new(Rails.configuration.customerio[:site_id],
                              Rails.configuration.customerio[:api_key])