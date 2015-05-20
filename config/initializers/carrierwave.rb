CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                       # required
    :aws_access_key_id      => 'AKIAJMQVN6LAXR62EAXQ',                      # required
    :aws_secret_access_key  => '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',  # required
  }
  config.fog_directory  = 'fabriq'                              # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end