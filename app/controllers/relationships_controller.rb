class RelationshipsController < ApplicationController
	include ProfilesHelper

	def create 
		followed = params[:followed]
		@profile = Profile.find(followed)
		current_profile.following << @profile
		@notification = Notification.new
		@notification.notified_by_id = current_profile.id
		@notification.profile_id = @profile.id
		@notification.notification_type = "follower"
		@notification.save

		respond_to do |format|
			format.js {}
		end
	end

	def destroy
		followed = params[:followed]
		@profile = Profile.find(followed)
		current_profile.unfollow(@profile)
		@notification = Notification.find_by(:notified_by_id => current_profile.id,
																				:profile_id => @profile.id,
																				:notification_type => "follower")
		@notification.destroy
		respond_to do |format|
			format.js {}
		end
	end

	def following_modal
		@user_profile = Profile.find(params[:profile_id])
		respond_to do |format|
			format.js {}
		end
	end

	def followers_modal
		@user_profile = Profile.find(params[:profile_id])
		respond_to do |format|
			format.js {}
		end
	end
end
