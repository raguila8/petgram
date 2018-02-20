require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:rodrigo)
		@user1 = User.create!(username: "raguila8", email: "rodrigoaguilar887@gmail.com", password: "foobar", password_confirmation: "foobar")

	end

	test "login with invalid information" do
		get new_user_session_path
		assert_template 'devise/sessions/new'
		post user_session_path, params: { session: { email: "", password: ""} }
		assert_template 'devise/sessions/new'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end	
	
	test "login with valid information followed by logout" do
		get new_user_session_path
		assert_template 'devise/sessions/new'
		post user_session_path, params: { user: { email: @user1.email , password: "foobar" } }
		assert_redirected_to root_path
		follow_redirect!
	end
end
