class UsersController < ApplicationController
	def show
		@user = params[:id].nil? ? current_user : User.find(params[:id])
	end
end
