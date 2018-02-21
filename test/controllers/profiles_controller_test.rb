require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

	def setup
		@profile = profiles(:one)
		@user = users(:rodrigo)
		@other_user = (:other)
		@user1 = User.create(username: "raguila8", email: "rodrigoaguilar887@gmail.com", password: "foobar", password_confirmation: "foobar")
		@profile1 = Profile.create(user_id: @user1.id, name: "Choco", username: "raguila8", bio: "I am a brown dog", animal: "Dog")

	end

	test "should get profile page when signed in" do
		sign_in @user
		get profile_path(@profile.id)
		assert_response :success
		assert_template 'profiles/show'
	end

	test "should redirect show when not logged in" do
		get profile_path(@profile.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should get edit when signed in" do
		sign_in @user
		get edit_profile_path(@profile.id)
		assert_response :success
		assert_template 'profiles/edit'
	end

	test "should redirect edit when not signed in" do
		get edit_profile_path(@profile.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect update when not signed in" do
		patch update_edit_profile_path(@profile.id), params: { profile: { username: "random123", name: "another", bio: "lwjdlifhwli", animal: "cat" } }
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect update when signed in as wrong profile" do
		sign_in @user1
		patch update_edit_profile_path(@profile.id), params: { profile: { username: "random123", name: "another", bio: "lwjdlifhwli", animal: "cat" } }
		assert_redirected_to root_path
	end

	test "should redirect edit when signed in as wrong profile" do
		sign_in @user1
		patch edit_profile_path(@profile.id), params: { profile: { username: "random123", name: "another", bio: "lwjdlifhwli", animal: "cat" } }	
		assert_redirected_to root_path
	end

	test "should redirect new when not signed in" do
		get new_profile_path
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should get new when signed in" do
		sign_in @user1
		get new_profile_path
		assert_response :success
		assert_template 'profiles/new'
	end

	test "should redirect welcome when not signed in" do
		get welcome_path(@profile.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should get welcome when signed in" do
		sign_in @user1
		get welcome_path(@profile1.id)
		assert_response :success
		assert_template 'profiles/welcome'
	end

	test "should redirect welcome when signed in as wrong profile" do
		sign_in @user1
		get welcome_path(@profile.id)
		assert_redirected_to root_path
	end

	test "should redirect discover when not signed in" do
		get discover_path
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should get discover when signed in" do
		sign_in @user1
		get discover_path
		assert_response :success
		assert_template 'profiles/discover'
	end

	test "should redirect change_profile when not signed in" do
		get change_profile_path
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect edit_pet_type when not signed in" do
		patch edit_pet_type_path, params: { profile: { name: "big dog", animal: "dog" } }
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect set_pet_type when not signed in" do
		get set_pet_type_path
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should get set_pet_type when signed in" do
		sign_in @user1
		get set_pet_type_path
		assert_response :success
		assert_template 'profiles/set_pet_type'
	end

	test "should redirect create when not signed in" do
		post update_new_profile_path, params: { profile: { username: "username111", name: "name", animal: "bat" } } 
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect destroy when not signed in" do
		delete profile_path(@profile.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect destroy when signed in as wrong profile" do
		sign_in @user1
		delete profile_path(@profile.id)
		assert_redirected_to root_path
	end
end
