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



end
