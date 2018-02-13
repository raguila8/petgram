#app/conarollers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
	# inherit from devise controller
	def new
		super
	end

	# custom sign up. Should create a profile upon sign up.
	def create
		@user = User.new(user_params)
		if @user.save
			profile = Profile.new
			profile.user_id = @user.id
			profile.username = @user.username
			profile.save
			sign_in(@user, scope: :user)
			flash[:success] = "Welcome to Petgram!"
			#redirect_to edit_profile_path(profile.id)
			redirect_to welcome_path(:id => profile.id)
			#:controller => 'profile', :action => 'edit'
		else
			render 'new'
		end
	end

	# inherit from devise controller
	def update
		super
	end

	def destroy 
		super
	end

	def edit
		super
	end

	def cancel
		super
	end

	private 

		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end
end
