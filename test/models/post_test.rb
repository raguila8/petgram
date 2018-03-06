require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
		FactoryBot.factories.clear
		FactoryBot.find_definitions

		@user = create(:user1)
		@profile1 = create(:profile1)
		@post1 = build(:post1)
		#image = fixture_file_upload('files/test1.jpg','image/jpg')
		#@post = Post.create(:id => @post1.id, :description => @post1.description, :image => image)
	end

	test "file should upload" do
		assert_not @post1.image.profile_post2.url.nil?	
		assert @post1.valid?
	end

	test "should belong to profile" do
		assert_not @post1.profile.nil?
	end

	test "description should not be too long" do
		@post1.description = "a" * 151
		assert_not @post1.valid?
	end

	test "should have many comments" do
		@post1.save
		create(:comment1)
		create(:comment1)
		assert_equal 2, @post1.comments.count
	end

	test "should have many notifications" do
		@post1.save
		create(:profile2)
		create(:notification1)
		assert_equal 1, @post1.notifications.count
	end

	test "notiications depend on post" do
		@post1.save
		create(:profile2)
		create(:notification1)

		assert_equal 1, Notification.all.count
		@post1.destroy
		assert_equal 0, Notification.all.count
	end

	test "comments should get destroyed when post is destroyed" do
		@post1.save
		create(:comment1)
		create(:comment1)

		assert_equal 2, Comment.all.count
		@post1.destroy
		assert_equal 0, Comment.all.count
	end
end
