CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                       # required
    :aws_access_key_id      => 'AKIAIXGGA5U2BIHEWMAA',                      # required
    :aws_secret_access_key  => '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',  # required
  }
  config.fog_directory  = 'fabriq'                              # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end





