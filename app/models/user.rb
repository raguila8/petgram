class User < ApplicationRecord
	has_many :profiles, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	before_save { self.email = email.downcase }
	validates :username, presence: true, length: { maximum: 20 },
												uniqueness: true

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, length: { maximum: 255 }
=begin
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
=end
end
