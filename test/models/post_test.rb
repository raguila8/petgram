require 'test_helper'

include FactoryBot::Syntax::Methods

class PostTest < ActiveSupport::TestCase
  def setup 
		@post1 = posts(:one)
		#image = fixture_file_upload('files/test1.jpg','image/jpg')
		#@post = Post.create(:id => @post1.id, :description => @post1.description, :image => image)
	end

	test "file should upload" do
		assert_not @post1.image.profile_post2.url.nil?	
		# Cant get this to work...
		#assert @post.valid?
	end

	test "should belong to profile" do
		assert_not @post1.profile.nil?
	end

	test "description should not be too long" do
		@post1.description = "a" * 151
		assert_not @post1.valid?
	end

	test "should have many comments" do
		assert_equal 2, @post1.comments.count
	end

	test "should have many notifications" do
		assert_equal 1, @post1.notifications.count
	end

	test "notiications depend on post" do
		assert_equal 2, Notification.all.count
		@post1.destroy
		assert_equal 1, Notification.all.count
	end

	test "comments should get destroyed when post is destroyed" do
		assert_equal 2, Comment.all.count
		@post1.destroy
		assert_equal 0, Comment.all.count
	end

	

	
end
