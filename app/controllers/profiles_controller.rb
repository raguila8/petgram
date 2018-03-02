class ProfilesController < ApplicationController
include ApplicationHelper
include ProfilesHelper
	before_action :logged_in_user
	before_action :find_profile, only: [:show, :edit, :update, :welcome, 
																			:change_profile]
	before_action :correct_profile, only: [:edit, :update, :welcome]
	before_action :get_current_profile, only: [:update_profile_image, 
																							:set_pet_type, :edit_pet_type ]
	before_action :owns_profile, only: [:destroy]

	def show
	end

	def edit
		@profile.email = @profile.user.email
	end

	def update_profile_image
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
		if @profile.profile_image.profile.url.nil?
			num = rand(115) + 1
			default_image = File.open(File.join(Rails.root, "/public/profile_icons/#{num}.png"))

			@profile.update_attributes(:profile_image => default_image)
		end
	end

	def edit_pet_type
		if @profile.update_attributes(profile_pet_type_params)
			# Handle a successful update
			flash[:success] = "Profile updated"
			redirect_to discover_path
		else
			flash[:danger] = "profile update did not work"
			render 'set_pet_type'
		end
	end

	def update
		@user = @profile.user
		@profile.email = params[:profile][:email]
		if @profile.update_attributes(profile_update_params) && @user.update_attributes(email: @profile.email)
			# Handle a successful update
			flash[:success] = "Profile update"
			redirect_to @profile
		else
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
			if current_user.username = @profile.username
				current_user.profiles.each do |p|
					if current_user.username != p.username
						current_user.update_attributes(:username => p.username)
						break
					end
				end
			end
			@profile.destroy
			redirect_to user_path(current_user)
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

	end

	def change_profile
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
		def correct_profile
			# this allows user to update any profile that belongs to him only
			redirect_to(root_url) unless @profile == current_profile
		end

		def owns_profile
			redirect_to(root_url) unless current_user.profiles.include? @profile
		end
		
		def get_current_profile
			@profile = current_profile
		end

		def find_profile
			@profile = Profile.find(params[:id])
		end
end
