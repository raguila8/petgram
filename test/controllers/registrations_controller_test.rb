require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
	def setup
		@user = users(:rodrigo)
		@other_user = users(:other)
	end

	test "should get signup_page" do
		get new_user_registration_path
		assert_response :success
		assert_select "title", "Signup | Petgram"
	end

	test "should redirect edit when not logged in" do
		get edit_user_registration_path(@user.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect update when not logged in" do
		patch update_edit_user_registration_path(@user.id), params: { user: {password: "password", 
				password_confirmation: "password",
				current_password: "foobar" } }
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect edit when logged in as wrong user" do
		#post user_session_path, params: { user: { email: 'random@email.com',
		#													password: 'foobar' } }
		sign_in @user
		
		get edit_user_registration_path(@other_user.id)
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
		#post user_session_path, params: { user: { email: 'random@email.com',
		#													password: 'foobar' } }
		sign_in @user
		
		patch update_edit_user_registration_path(@other_user.id), params: { user: {password: "password", 
				password_confirmation: "password",
				current_password: "foobar" } }

		assert_redirected_to root_url
	end

	test "should redirect on destroy when not logged in" do
		delete user_registration_path
		assert_not flash.empty?
		assert_redirected_to new_user_session_path

	end	
end
