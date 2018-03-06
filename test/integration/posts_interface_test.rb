# Struggling towards reliable capybara javascript testing
require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		FactoryBot.factories.clear
		FactoryBot.find_definitions

		@user = create(:user1)
		@profile = create(:profile1)
		
	end

	# assert_no_css('#image-upload-modal') causes race condition
	test "successful post submission" do
		sign_in @user
		visit(profile_path(@profile.id))
		assert_css('a#image-upload-toggle')
		#assert_no_css('#image-upload-modal')
		find('a#image-upload-toggle button').click
		assert_css("#image-upload-modal")
		# Valid submission
		description = "This is a test"
		fill_in('post[description]', with: description)
		find('#image-upload-modal .file-btn').click
		attach_file('post[image]', File.join(Rails.root, '/test/fixtures/files/test1.jpg'), make_visible: true)
		#	 Submit post
		find('#image-upload-modal .login101-form-btn').click
		# Post is added to your profile page
		assert_css('.profile-post-container')
	end
=begin
	test "image preview when image selected" do
		# Force sleep to clean up previous test
		sleep 2
		sign_in @user
		visit(profile_path(@profile.id))
		assert_css('a#image-upload-toggle')
		find('a#image-upload-toggle button').click
		# Valid submission
		description = "This is a test"
		fill_in('post[description]', with: description)
		#assert_no_css('#image-upload-modal .upload-preview img')
		assert page.find('#image-upload-modal .upload-preview img')[:src].blank?
		find('#image-upload-modal .file-btn').click
		attach_file('post[image]', 'test/fixtures/files/test1.jpg')
		#page.execute_script("$('.img-file').trigger('change');")
		assert_css('#image-upload-modal .upload-preview img')
		# Force wait to run ajax
		sleep 3
		assert page.find('#image-upload-modal .upload-preview img')[:src].present?
	end
=end
	private 

end
