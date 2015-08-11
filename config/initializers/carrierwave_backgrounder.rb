CarrierWave::Backgrounder.configure do |c|
  c.backend :sidekiq, queue: :carrierwave, cleanup: false
end
