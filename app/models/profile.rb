class Profile < ApplicationRecord
	mount_uploader :profile_image, ImageUploader
	has_many :posts, dependent: :destroy
	has_many :active_relationships, class_name: "Relationship",
																	foreign_key: "follower_id",
																	dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship",
																	foreign_key: "followed_id",
																	dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	has_many :notifications, dependent: :destroy

	belongs_to :user
	acts_as_voter
	# This is for the email_field for the form in profiles#edit view.
	attr_accessor :email

	validates :username, presence: true, length: { maximum: 25 },
												uniqueness: true

	
	# Follows a user
	def follow(other_user)
		self.following << other_user
	end

	# Unfollows a user
	def unfollow(other_user)
		self.following.delete(other_user)
	end

	# Returns true if the current user is following the other user.
	def following?(other_user)
		self.following.include?(other_user)
	end

	# Defines a feed
	def feed
		following_ids = "SELECT followed_id FROM relationships
											WHERE follower_id = :profile_id"
		Post.where("profile_id IN (#{following_ids}) 
							OR profile_id = :profile_id", profile_id: self.id)
	end

	def suggestions
		follower_ids = "SELECT follower_id FROM relationships
										WHERE followed_id = :id"
		following_ids = "SELECT followed_id FROM relationships
										WHERE follower_id = :id"
		sql = "SELECT followed_id AS profile_id
					FROM relationships 
					GROUP BY followed_id
					ORDER BY COUNT(follower_id) DESC
					LIMIT 20"
		
		popular = Profile.where("(id IN (#{sql}) AND NOT id = :id) OR (id IN (#{follower_ids}) AND id NOT IN (#{following_ids}))", id: self.id)
		#popular << Profile.where("profile_id IN #{follower_ids} AND profile_id NOT IN #{following_ids}")
		return popular
	end

	def search(pattern)
=begin
 _following_ids = "SELECT followed_id FROM relationships
											WHERE follower_id = :profile_id"

		
		_suggestions = "id FROM profiles 
		 WHERE username LIKE '#{pattern}'
		LIMIT 30"
AND
		 profile_id IN (#{following_ids})
		 UNION
		 SELECT profile_id FROM profiles
		 WHERE username LIKE '#{pattern}'
		 LIMIT 30"
=end
		result = Profile.where("username LIKE '#{pattern}'").limit(30)
	
		return result	
	end

end
