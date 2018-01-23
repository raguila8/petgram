require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  
	def setup 
		@user = users(:rodrigo)
		@profile1 = profiles(:one)
	end

	test "should be valid" do
		assert @profile1.valid?
	end

	test "username should be present" do
		@user.username = "   "
		assert_not @user.valid?
	end	

	test "username should not be too long" do
		@user.username = "a" * 26
		assert_not @user.valid?
	end

	test "profile belongs_to user" do
		assert_not @profile1.user.nil?
	end

end
