module ApplicationHelper

	# if user is not logged in, user is redirected to login page
	
	def logged_in_user
		if !user_signed_in?
			flash[:error] = "You need to sign in or sign up before continuing."

			redirect_to new_user_session_path
		end
	end

	# confirms the correct user
	def correct_user
		@user = User.find(params[:id])		
		redirect_to(root_url) unless @user == current_user
	end

	# edit_profile pages require auth_stylesheets. We use method in application 
	# layout to load auth_stylesheets.
	def edit_profile_page?
		if ["registrations", "users"].include?(controller_name) ||
			(controller_name == "profiles" && ["edit", "new"].include?(action_name))
			true
		else
			false
		end

	end

	# Page specific javascripts loaded in application layout header
	def page_specific_javascripts
		action = action_name
		controller = controller_name
		if controller == "posts"
			["home", "post_settings_modal"]

		elsif controller == "profiles"
			javascripts = ['relationships', 'image_modal', 'relationships_modal', 
											'post_settings_modal']

				javascripts += ['discover', 'home'] if action == "discover"
				return javascripts
		end
	end
end
