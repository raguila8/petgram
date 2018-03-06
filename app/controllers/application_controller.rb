class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	layout :layout_by_resource
	

	private 

	# login and signup pages have a different layout
	def layout_by_resource
		controller = controller_name
		action = action_name
		if ["sessions", "passwords"].include?(controller) || 
			(controller == "registrations" && action == "new") || 
			(controller == "profiles" && ["welcome", "set_pet_type"].include?(action))
			"auth"
		else
			"application"
		end
	end	
end
