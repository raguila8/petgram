class ProfilesController < ApplicationController
include ApplicationHelper
include ProfilesHelper
	before_action :logged_in_user
	#before_action :correct_user, only: [:edit, :update]
	def show
		@profile = Profile.find(params[:id])
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

		if params[:path] == 'show'
			redirect_to @profile
		elsif params[:path] == 'edit' 
			redirect_to edit_profile_path(@profile.id)
		elsif params[:path] == 'welcome'
			redirect_to set_pet_type_path
		elsif params[:path] == 'welcome/default'
			@profile.update_attributes(:profile_image => File.open(File.join(Rails.root, "/public/#{params[:profile][:profile_image]}")))
			redirect_to set_pet_type_path
		end

	end

	def set_pet_type
		@profile = current_profile
	end

	def edit_pet_type
		@profile = current_profile
		if @profile.update_attributes(profile_pet_type_params)
			# Handle a successful update
			flash[:success] = "Profile updated"
			redirect_to discover_path
		else
			#redirect_to edit_profile_path(@profile.id)
			flash[:danger] = "profile update did not work"
			render 'set_pet_type'
		end
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
				current_user.profiles.each do |p|
					if current_user.username != p.username
						current_user.update_attributes(:username => p.username)
						break
					end
				end
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

	def welcome
		@profile = Profile.find(params[:id])
	end
		
	def animal_type
		
	end

	def change_profile
		@profile = Profile.find(params[:id])
		current_user.update_attributes(:username => @profile.username)
		redirect_to @profile
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

		def profile_pet_type_params
			params.require(:profile).permit(:name, :animal)
		end

		# Confirms the correct user
		def correct_user
			@profile = Profile.find(params[:id])
			# this allows user to update any profile that beongs to him
			redirect_to(root_url) unless @profile.user == current_user
		end

		def logged_in_user
			if !user_signed_in?
				flash[:error] = "You need to sign in or sign up before continuing."

				redirect_to new_user_session_path
			end
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
