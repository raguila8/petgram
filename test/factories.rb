# User Factories

FactoryBot.define do
	factory :user1, class: User do
		id 1
		username "rodrigo1"
		email "random1@email.com"
		password "foobar"
		password_confirmation "foobar"
	end
end

FactoryBot.define do
	factory :user2, class: User do
		id 2
		username "other_user"
		email "random2@email.com"
		password "foobar"
		password_confirmation "foobar"
	end
end

# Profile Factories

FactoryBot.define do
	factory :profile1, class: Profile do
		id 1
		username "rodrigo1"
		user_id 1
	end
end

FactoryBot.define do
	factory :profile2, class: Profile do
		id 2
		username "rodrigo2"
		user_id 1
	end
end

# Post Factories

FactoryBot.define do
  factory :post1, class: Post do
		id 1
    profile_id 1
		image File.open(File.join(Rails.root, "/test/fixtures/files/test1.jpg"))
    #image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/test/fixtures/files/test1.jpg'))) }
	end
end

FactoryBot.define do
  factory :post2, class: Post do
		id 2
    profile_id 1
    image File.open(File.join(Rails.root, "/test/fixtures/files/test2.jpg"))
	end
end

# Relationships Factories

FactoryBot.define do
  factory :relationship1, class: Relationship do
    follower_id 1
    followed_id 2
	end
end

FactoryBot.define do
  factory :relationship2, class: Relationship do
    follower_id 2
    followed_id 1
	end
end

# Notifications factories

FactoryBot.define do
  factory :notification1, class: Notification do
    profile_id 1 
    notified_by_id 2
		post_id 1
		notification_type "like"
		read false
	end
end

FactoryBot.define do
  factory :notification2, class: Notification do
    profile_id 1
    notified_by_id 2
		post_id 2
		notification_type "comment"
		read false
	end
end

# Comments factories

FactoryBot.define do
  factory :comment1, class: Comment do
    content "this is a comment"
    profile_id 1
		post_id 1
	end
end
=begin
FactoryBot.define do
  factory :comment2, class: Comment do
    content "this is a comment"
    profile_id 1
		post_id 1
	end
end
=end

