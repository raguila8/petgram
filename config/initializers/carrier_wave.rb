require 'carrierwave/orm/activerecord'

# NullStorage provider for CarrierWave for use in tests.  Doesn't actually
# upload or store files but allows test to pass as if files were stored and
# the use of fixtures.

CarrierWave.configure do |config|	

	if Rails.env.production? || Rails.env.staging?
		#def store_dir
    #	"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  	#end

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
		#def store_dir
    #	"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
 	  #end

	elsif Rails.env.test?
		config.storage :file
		
=begin
		def cache_dir
    	"test/uploads/tmp"
    end

    def store_dir
    	"test/uploads/kejhfke#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

		#config.cache_dir = cache_dir
		config.root = "#{Rails.root}/public/test"
		
=end
		# Speeds up tests considerably
		#config.enable_processing = false

	end	

end

