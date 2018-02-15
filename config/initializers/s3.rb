CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAJBNEOEY6M27OWFJA",
      :aws_secret_access_key  => "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",
      :region                 => 'us-west-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "petgram"
end
