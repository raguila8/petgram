require 'carrierwave/orm/activerecord'

# NullStorage provider for CarrierWave for use in tests.  Doesn't actually
# upload or store files but allows test to pass as if files were stored and
# the use of fixtures.
class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end

CarrierWave.configure do |config|

	if Rails.env.production? || Rails.env.staging?
  	config.fog_provider = 'fog/aws'                        # required
  	config.fog_credentials = {
    	provider:              'AWS',                        # required
    	aws_access_key_id:     ENV["S3_ACCESS_KEY"],        # required
    	aws_secret_access_key: ENV["S3_SECRET_KEY"],        # required
			region: 'us-west-1'
 	 	}
		config.storage :fog
  	config.fog_directory  = ENV["S3_BUCKET"]              # required
	elsif Rails.env.development?
		config.storage :file

	elsif Rails.env.test?
		config.storage :file

		# Speeds up tests considerably
		#config.enable_processing = false
	end
end
