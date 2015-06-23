CARRIERWAVE_CONFIG = {
  provider: 'AWS',
  aws_access_key_id: A9n.aws[:access_key_id],
  aws_secret_access_key: A9n.aws[:secret_access_key],
  region: A9n.aws[:region]
}

CarrierWave.configure do |config|
  config.fog_credentials = CARRIERWAVE_CONFIG
  config.fog_directory  = A9n.aws[:bucket_name]
end
