module ProfilesHelper
	def set_edit_profile_class
		((controller_name == "profiles") && (action_name == "update" || action_name == "edit")) ? "active-effect-4" : "non-active-effect-4" 

	end

	def set_edit_password_class
		((devise_controller?) && (action_name == "update" || action_name == "edit")) ? "active-effect-4" : "non-active-effect-4" 

	end

	def set_add_profile_class
		((controller_name == "profiles") && (action_name == "new" || action_name == "create")) ? "active-effect-4" : "non-active-effect-4" 
	end

	def set_profiles_class
		((controller_name == "users") && (action_name == "show")) ? "active-effect-4" : "non-active-effect-4" 
	end

	def current_profile
		Profile.find_by(username: current_user.username)
	end

end
