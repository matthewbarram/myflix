CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAISYH3FGFZFDHVUJA',                        # required
    :aws_secret_access_key  => 'AKIAISYH3FGFZFDHVUJA',                        # required
    :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
    :host                   => 's3-website-us-east-1.amazonaws.com',             # optional, defaults to nil
    :endpoint               => 'myflix_test.s3-website-us-east-1.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'pictures'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
