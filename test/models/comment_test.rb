require 'test_helper'

class CommentTest < ActiveSupport::TestCase
=begin
  def setup 
		@comment1 = comments(:one)
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

	test "should belong to profile" do
		assert_not @comment1.profile.nil?
	end

	test "should belong to post" do
		assert_not @comment1.post.nil?
	end
=end
end
