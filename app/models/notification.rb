class Notification < ApplicationRecord
	belongs_to :profile, class_name: "Profile"
	belongs_to :notified_by, class_name: "Profile"
	belongs_to :post, class_name: "Post", optional: true
	validates :profile_id, presence: true
	validates :notified_by_id, presence: true
	validates :notification_type, presence: true, inclusion: { in: %w(like comment follower) }

	
end
