require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup 
		#@comment1 = comments(:one)
		FactoryBot.factories.clear
		FactoryBot.find_definitions

		create(:user1)
		create(:profile1)
		create(:post1)
		@comment1 = build(:comment1)
	end

	test "should be valid" do
		assert @comment1.valid?
	end

	test "profile_id should be present" do
		@comment1.profile_id = ""
		assert_not @comment1.valid?
	end

	test "post_id should be present" do
		@comment1.profile_id = ""
		assert_not @comment1.valid?
	end

	test "content should be present" do
		@comment1.content = "  "
		assert_not @comment1.valid?
	end

	test "content should not be too long" do
		@comment1.content = "a" * 151
		assert_not @comment1.valid?
	end

	test "should belong to profile" do
		assert_not @comment1.profile.nil?
	end

	test "should belong to post" do
		assert_not @comment1.post.nil?
	end
end
