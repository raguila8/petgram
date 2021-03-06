class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :fog
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
	if Rails.env.test?
		def cache_dir
    	"test/uploads/tmp"
    end

    def store_dir
    	"test/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

	else
		def store_dir
    	"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  	end
	end

	def auto_orient
		manipulate! do |img|
			img = img.auto_orient
		end
	end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :profile do
		process :auto_orient
    process resize_to_fit: [150, 150]
  end

	version :thumb do
		process :auto_orient
		process resize_to_fit: [30, 30]
	end

	version :profile_post do
		process :auto_orient
		process resize_to_fill: [500, 500]
	end

	version :profile_post1 do
		process :auto_orient
		process resize_to_fit: [600, 600]
	end

	version :profile_post2 do
		process :auto_orient
		process resize_to_fill: [300, 300]
	end
	

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
