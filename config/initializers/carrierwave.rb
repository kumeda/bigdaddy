CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     'AKIAI22EWYLR2GMK5XAA',                        # required
      aws_secret_access_key: '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',                        # required
      region:                'ap-northeast-1',                  # optional, defaults to 'us-east-1'
      # host:                  's3.example.com',             # optional, defaults to nil
      # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }

  case Rails.env
    when 'production'
      config.fog_directory = 'prd-happyhour-club'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/prd-happyhour-club'

    when 'development'
      config.fog_directory = 'dev-happyhour-club'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dev-happyhour-club'

    when 'test'
      config.fog_directory = 'test-happyhour-club'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/test-happyhour-club'
  end
end