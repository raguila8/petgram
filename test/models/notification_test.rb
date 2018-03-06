require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
		#@notification1 = notifications(:one)		
		FactoryBot.factories.clear
		FactoryBot.find_definitions

		create(:user1)
		create(:profile1)
		create(:profile2)
		create(:post1)
		create(:post2)
		@notification1 = build(:notification1)
	end

	test "should be valid" do
		assert @notification1.valid?
	end

	test "belongs to profile" do
		assert_not @notification1.profile.nil?
	end

	test "belongs to notified_by through profile model" do
		assert_not @notification1.notified_by.nil?
	end

	test "belongs to post" do
		assert_not @notification1.post.nil?
	end

	test "profile_id should be present" do
		@notification1.profile_id = ""
		assert_not @notification1.valid?
	end

	test "notified_by_id should be present" do
		@notification1.notified_by_id = ""
		assert_not @notification1.valid?
	end

	test "notification_type should be present" do
		@notification1.notification_type = " "
		assert_not @notification1.valid?
	end

	test "notification_type should either 'like', 'comment' or 'follower'" do
		@notification1.notification_type = "hello"
		assert_not @notification1.valid?
		["like", "comment", "follower"].each do |w|
			@notification1.notification_type = w
			assert @notification1.valid?
		end
	end
end
