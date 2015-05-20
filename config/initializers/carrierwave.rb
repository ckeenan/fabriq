CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                       # required
    :aws_access_key_id      => 'AKIAJEWD6XXLGDJ222PQ',                      # required
    :aws_secret_access_key  => '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',  # required
  }
  config.fog_directory  = 'fabriq'                              # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end




