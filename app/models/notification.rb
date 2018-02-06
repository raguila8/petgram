class Notification < ApplicationRecord
	belongs_to :profile, class_name: "Profile"
	belongs_to :notified_by, class_name: "Profile"
	belongs_to :post, class_name: "Post"
	validates :profile_id, presence: true
	validates :notified_by_id, presence: true
	validates :notification_type, presence: true

	
end
