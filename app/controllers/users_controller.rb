class UsersController < ApplicationController
include ApplicationHelper
	#before_action :logged_in_user, only: [:show]
	#before_action :correct_user, only: [:show]

	def show
		@user = current_user
	end
	
	def delete
		@user = current_user
	end

	private

		# confirms the correct user
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless @user == current_user
		end
end
