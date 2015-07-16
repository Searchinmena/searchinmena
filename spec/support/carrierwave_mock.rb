Fog.mock!
connection = Fog::Storage.new(CARRIERWAVE_CONFIG)
connection.directories.create(key: A9n.aws[:bucket_name])
