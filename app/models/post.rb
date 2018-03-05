class Post < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :profile
	has_many :comments, dependent: :destroy
	has_many :notifications, dependent: :destroy
	acts_as_votable

	validates :image, presence: true
	validates :description, length: { maximum: 150 }
	validate :image_size

	private

		# Validates the size of an uploaded picture.
		def image_size
			if image.size > 5.megabytes
				errors.add(:image, "should be less than 5MB")
			end
		end
end
