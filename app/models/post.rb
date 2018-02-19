class Post < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :profile
	has_many :comments, dependent: :destroy
	has_many :notifications, dependent: :destroy
	acts_as_votable

	validates :image, presence: true
	validates :description, length: { maximum: 150 }
end
