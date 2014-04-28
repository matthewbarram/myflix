CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV["S3_ACCESS_KEY"],                        # required
      :aws_secret_access_key  => ENV["S3_SECRET_ACCESS_KEY"],                        # required

    }
    config.fog_directory  = "myflix_test"
    config.fog_public = false
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end
