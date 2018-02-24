class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	layout :layout_by_resource
	

	private 

	# login and signup pages have a different layout
	def layout_by_resource
		controller = controller_name
		action = action_name
		if controller == "sessions" || 
			(["registrations", "profiles"].include?(controller) && 
				action == ["new", "welcome", "set_pet_type"].include?(action))
			"auth"
		else
			"application"
		end
	end	
end
