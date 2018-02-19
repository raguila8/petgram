require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
		@relationship1 = relationships(:one)
	end

	test "relationship is valid" do
		assert @relationship1.valid?
	end

	test "follower_id should be present" do
		@relationship1.follower_id = ""
		assert_not @relationship1.valid?
	end

	test "following_id should be present" do
		@relationship1.followed_id = ""
		assert_not @relationship1.valid?
	end

	test "should belong to follower" do
		assert_not @relationship1.follower.nil?
	end

	test "should belong to foolwed" do
		assert_not @relationship1.followed.nil?
	end
end
