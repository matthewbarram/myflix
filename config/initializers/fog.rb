CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAIGW6QH5BAEYL3YLA',                        # required
    :aws_secret_access_key  => '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',                        # required
    # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-    :host                   => 's3-website-us-east-1.amazonaws.com',             # optional, defaults to nil
    # :endpoint               => 'https://myflix_test.s3-website-us-east-1.amazonaws.com:8080' # optional, defaults to nil1'

  }
  config.fog_directory  = :pictures                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
