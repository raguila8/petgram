class UsersController < ApplicationController
include ApplicationHelper
	before_action :logged_in_user, only: [:show, :delete]
	before_action :correct_user, only: [:show]

	def show
		@user = current_user
	end
	
	def delete
		@user = current_user
	end

	private

				
end
