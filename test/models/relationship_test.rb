require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
		#@relationship1 = relationships(:one)
		FactoryBot.factories.clear
		FactoryBot.find_definitions
		
		create(:user1)
		create(:profile1)
		create(:profile2)
		@relationship1 = build(:relationship1)
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

	test "should belong to follwed" do
		assert_not @relationship1.followed.nil?
	end
end
