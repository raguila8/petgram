require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		FactoryBot.factories.clear
		FactoryBot.find_definitions

		@user = create(:user1)
		@profile1 = create(:profile1)
		@other_user = create(:user2)
		@other_profile = create(:profile2, user_id: 2)
		#@user = users(:rodrigo)
		#@user1 = User.create(username: "raguila8", email: "rodrigoaguilar887@gmail.com", password: "foobar", password_confirmation: "foobar")
		#@profile1 = Profile.create(user_id: @user1.id, name: "Choco", username: "raguila8", bio: "I am a brown dog", animal: "Dog")
	end

	test "should get show page when signed in" do
		sign_in @user
		get user_path(@user.id)
		assert_response :success
		assert_template 'users/show'
	end

	test "should get delete profiles page when signed in" do
		sign_in @user
		get delete_profiles_path
		assert_response :success
		assert_template 'users/delete'
	end

	test "should redirect show when not signed in" do
		get user_path(@user.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect delete when not signed in" do
		get delete_profiles_path
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect show when signed in as wrong user" do
		sign_in @other_user
		get user_path(@user.id)
		assert_redirected_to root_path
	end

end
