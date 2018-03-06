require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		#@user = users(:rodrigo)
		@user1 = User.create(username: "raguila8", email: "rodrigoaguilar887@gmail.com", password: "foobar", password_confirmation: "foobar")
		@profile1 = Profile.create(user_id: @user1.id, name: "Choco", username: "raguila8", bio: "I am a brown dog", animal: "Dog")

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
		assert_redirected_to root_path	# redirects to feed page
		follow_redirect!
		# if no posts in feed then user is redirected to discover page
		assert_redirected_to discover_path
		follow_redirect!
		assert_template 'profiles/discover'
		# logout
		delete destroy_user_session_path
		# redirected to signup page
		assert_redirected_to root_path
		follow_redirect!
		assert_template 'devise/registrations/new'
	end

end
