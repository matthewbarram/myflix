CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAI4HBWQG247SSRKYQ',                        # required
      :aws_secret_access_key  => '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',                        # required

    }
    config.fog_directory  = "myflix_test"                 # required
    config.fog_public = false
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end
