class Profile < ApplicationRecord
	belongs_to :user

	validates :username, presence: true, length: { maximum: 25 },
												uniqueness: true

end
