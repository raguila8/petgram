class Profile < ApplicationRecord
	belongs_to :user
	# This is for the email_field for the form in profiles#edit view.
	attr_accessor :email

	validates :username, presence: true, length: { maximum: 25 },
												uniqueness: true

end
