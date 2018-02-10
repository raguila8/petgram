class ProfilesController < ApplicationController
include ApplicationHelper
include ProfilesHelper
	before_action :logged_in_user, only: [:edit, :update, :new, :create, :show]
	before_action :correct_user, only: [:edit, :update]
	def show
		@profile = Profile.find_by(user_id: current_user.id)
		@post = Post.new
	end

	def edit
		@profile = Profile.find(params[:id])
		@profile.email = @profile.user.email
	end

	def update_profile_image
		@profile = current_profile
		if @profile.update_attributes(profile_image_update_params)
			# Handle a successful update
			flash[:success] = "Profile image updated"
		else
			#redirect_to edit_profile_path(@profile.id)
			flash[:error] = "profile image did not update"
		end
		redirect_to @profile

	end

	def update
		@profile = Profile.find(params[:id])
		@user = @profile.user
		@profile.email = params[:profile][:email]
		if @profile.update_attributes(profile_update_params) && @user.update_attributes(email: @profile.email)
			# Handle a successful update
			flash[:success] = "Profile update"
			redirect_to @profile
		else
			#redirect_to edit_profile_path(@profile.id)
			render 'edit'
		end
	end

	def new
		@profile = Profile.new
	end

	def create
		@profile = Profile.new(profile_create_params)
		@profile.user_id = current_user.id
		if @profile.save
			current_user.username = @profile.username
			flash[:success] = "New pet profile created!"
			#redirect_to edit_profile_path(@profile.id)
			redirect_to user_path(current_user)
		else
			render 'new'
		end
	end

	def destroy
		@user = current_user
		if @user.profiles.size == 1
			@user.profiles.first.destroy
			sign_out
			@user.destroy
			redirect_to new_user_registration_path
		else
			profile = Profile.find(params[:id])
			if current_user.username = profile.username
				current_user.username = current_user.profiles.first.username
			end
			profile.destroy
			redirect_to user_path
		end
	end

	def autocomplete
		respond_to do |format|
			format.json {
				@suggestions = current_profile.search("%#{params[:query]}%")
				render json: {suggestions: @suggestions }
			}
		end
	end

	def discover
		@suggestions = current_profile.suggestions
		@popular = Post.order(cached_votes_score: :desc)
	end
	
	def read_notifications
		if current_profile.notifications.count > 0
			current_profile.notifications.each do |n|
				n.read = true
				n.save
			end
		end
	end

	private
		
		def profile_update_params
			params.require(:profile).permit(:username, :name, :bio, :animal)
		end

		def profile_image_update_params
			params.require(:profile).permit(:profile_image)
		end

		def profile_create_params
			params.require(:profile).permit(:username, :name, :animal)
		end

		# Confirms the correct user
		def correct_user
			@profile = Profile.find(params[:id])
			# this allows user to update any profile that beongs to him
			redirect_to(root_url) unless @profile.user == current_user
		end

		
			# if user is not logged in, user is redirected to login page
=begin
		def logged_in_user
			unless user_signed_in?
				flash[:danger] = "Please log in."
				redirect_to new_user_session_path
			end
		end
=end
end
