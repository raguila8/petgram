require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  
	def setup 
		@profile1 = profiles(:one)
	end

	test "should be valid" do
		assert @profile1.valid?
	end

	test "username should be present" do
		@profile1.username = "   "
		assert_not @profile1.valid?
	end	

	test "username should not be too long" do
		@profile1.username = "a" * 21
		assert_not @profile1.valid?
	end

	test "profile belongs_to user" do
		assert_not @profile1.user.nil?
	end

	test "animal should not be too long" do
		@profile1.animal = "a" * 26
		assert_not @profile1.valid?
	end

	test "bio should not be too long" do
		@profile1.bio = "a" * 151
		assert_not @profile1.valid?
	end

	test "name should not be too long" do
		@profile1.name = "a" * 26
		assert_not @profile1.valid?
	end

	test "profile should have many posts" do
		#assert_equal 2, @profile1.posts.size
	end

	test "should have many following" do
		assert_equal 1, @profile1.following.size
	end

	test "should have many followers" do
		assert_equal 1, @profile1.followers.size
	end

	test "should have many notifications" do
		#assert_equal 1, @profile1.notifications.size
	end
=begin
	test "notifications depend on profile" do
		assert_equal 1, Notification.count
		@profile1.destroy
		assert_equal 0, Notification.count
	end
=end
	test "posts depend on profile" do
		#assert_equal 2, Post.count
		#@profile1.destroy
		#assert_equal 0, Post.count
	end

	
	# there is one passive and one active relationship
	# deleting a profile should delete any relationship that profile is a part of

	test "followers relationship depend on profile" do
		assert_equal 2, Relationship.count
		@profile1.destroy
		assert_equal 0, Relationship.count
	end

end
