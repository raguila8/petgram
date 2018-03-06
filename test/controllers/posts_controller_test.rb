require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

  setup do
		FactoryBot.factories.clear
		FactoryBot.find_definitions

		@user = create(:user1)
		@profile = create(:profile1)
		@post = create(:post1)

    #@post = posts(:one)
		#@user = users(:rodrigo)
  end

  test "should redirect home when not logged in" do
    get home_path
    assert_not flash.empty?
		assert_redirected_to new_user_session_path
  end

	test "should get home when signed in" do
		sign_in @user
		get home_path
		assert_response :success
		assert_template 'posts/home'
	end
	
	test "should redirect show when not logged in" do
		get post_path(@post.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should get show when signed in" do
		sign_in @user
		get post_path(@post.id)
		assert_response :success
		assert_template 'posts/show'
	end

	test "should redirect edit when not logged in" do
		get edit_post_path(@post.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should get edit when signed in" do
		sign_in @user
		get edit_post_path(@post.id)
		assert_response :success
		assert_template 'posts/edit'
	end

	test "should redirect create when not logged in" do
		post posts_path
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect update when not logged in" do
		patch post_path(@post.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end

	test "should redirect destroy when not logged in" do
		delete post_path(@post.id)
		assert_not flash.empty?
		assert_redirected_to new_user_session_path
	end
end
