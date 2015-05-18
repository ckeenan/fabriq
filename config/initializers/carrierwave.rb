CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                       # required
    :aws_access_key_id      => 'AKIAJ34AB7E2OW2WEVNQ',                      # required
    :aws_secret_access_key  => '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',  # required
  }
  config.fog_directory  = 'fabriq'                              # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end