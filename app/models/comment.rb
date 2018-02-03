class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :post

	validates :profile, presence: true
	validates :post, presence: true
	validates :content, presence: true
end
