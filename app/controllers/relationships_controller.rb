class RelationshipsController < ApplicationController
	include ProfilesHelper

	def create 
		followed = params[:followed]
		@profile = Profile.find(followed)
		current_profile.following << @profile
		respond_to do |format|
			format.js {}
		end
	end

	def destroy
		followed = params[:followed]
		@profile = Profile.find(followed)
		current_profile.unfollow(@profile)
		respond_to do |format|
			format.js {}
		end
	end
end
