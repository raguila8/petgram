module ProfilesHelper
	def set_edit_profile_class
		#current_page?(edit_profile_path(Profile.find_by(user_id: current_user.id)) || update_edit_profile_path(Profile.find_by(user_id: current_user.id))) ? "active-effect-4" : "non-active-effect-4" 
		((controller_name == "profiles") && (action_name == "update" || action_name == "edit")) ? "active-effect-4" : "non-active-effect-4" 

	end

	def set_edit_password_class
		#current_page?(edit_user_registration_path) ? "active-effect-4" : "non-active-effect-4"
		((devise_controller?) && (action_name == "update" || action_name == "edit")) ? "active-effect-4" : "non-active-effect-4" 

	end

	def set_add_profile_class
		#current_page?(new_profile_path) ? "active-effect-4" : "non-active-effect-4"
		((controller_name == "profiles") && (action_name == "new" || action_name == "create")) ? "active-effect-4" : "non-active-effect-4" 
	end

	def set_profiles_class
		((controller_name == "users") && (action_name == "show")) ? "active-effect-4" : "non-active-effect-4" 
	end

	def current_profile
		Profile.find_by(username: current_user.username)
	end

end
