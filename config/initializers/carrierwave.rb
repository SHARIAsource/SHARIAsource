CarrierWave.configure do |config|
  config.storage = (ENV['CARRIERWAVE_STORAGE'] || :file).to_sym
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.enable_processing = false
  end
end
