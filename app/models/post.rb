class Post < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :profile
	has_many :comments, dependent: :destroy
end
