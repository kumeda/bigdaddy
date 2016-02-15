CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAI22EWYLR2GMK5XAA',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
  }

  case Rails.env
    when 'production'
      config.fog_directory = 'prd.happyhour.club'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/prd.happyhour.club'

    when 'development'
      config.fog_directory = 'dev.happyhour.club'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dev.happyhour.club'

    when 'test'
      config.fog_directory = 'test.happyhour.club'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/test.happyhour.club'
  end
end