Rails.application.routes.draw do
	

	###################### DEVISE CONTROLLERS ##############################
	
	devise_for :users, skip: [:sessions, :registrations]
	devise_scope :user do
		get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
		post 'sign_in', to: 'devise/sessions#create', as: :user_session
  	delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
		get 'cancel_registration', to: 'registrations#cancel', as: :cancel_user_registration
		get 'sign_up', to: 'registrations#new', as: :new_user_registration
		get 'change_password/:id', to: 'registrations#edit', as: :edit_user_registration
		patch '/change_password/:id', to: 'registrations#update', as: :update_edit_user_registration
		put '/user_registration', to: 'registrations#update'
		delete '/user_registration', to: 'registrations#destroy'
		post '/user_registration', to: 'registrations#create'
	end

	##################### USERS CONTROLLER ##############################

	resources :users, only: [:show]
	get '/delete_profiles', to: 'users#delete', as: :delete_profiles


	####################### PROFILES CONTROLLER ############################

	resources :profiles, only: [:show, :edit, :new, :destroy] do 
		member do
			patch 'edit', action: :update, :as => :update_edit
		end
	end
	post '/profiles/new', to: 'profiles#create', as: :update_new_profile
	get '/autocomplete', to: 'profiles#autocomplete', as: :autocomplete
	get '/discover', to: 'profiles#discover', as: :discover
	patch '/update_profile_img', to: 'profiles#update_profile_image', as: :update_profile_image
	get '/read_notifications', to: 'profiles#read_notifications', as: :read_notifications
	get '/welcome/:id', to: 'profiles#welcome', as: :welcome
	get '/set_pet_type', to: 'profiles#set_pet_type', as: :set_pet_type
	patch '/edit_pet_type', to: 'profiles#edit_pet_type', as: :edit_pet_type
	get '/change_profile', to: 'profiles#change_profile', as: :change_profile
	
	########################## POSTS CONTROLLER ############################
  resources :posts, except: [:new, :index]
	get '/home', to: 'posts#home', as: :home
	get '/post_settings_modal', to: 'posts#open_post_settings_modal', as: :post_settings_modal
	get '/vote', to: 'posts#vote', as: :vote
	get '/post_modal', to: 'posts#post_modal', as: :post_modal


	######################### COMMENTS CONTROLLER ###########################

	post '/comments', to: 'comments#create', as: :comments
	delete '/comments', to: 'comments#destroy', as: :destroy_comment
	get '/get_comments', to: 'comments#get_comments', as: :get_comments
	get '/get_modal_comments', to: 'comments#get_modal_comments', as: :get_modal_comments
	post '/modal_comments', to: 'comments#create_modal_comment', as: :modal_comments

	######################## RELATIONSHIPS CONTROLLER ##########################
	
	post '/follow', to: 'relationships#create', as: :follow
	get '/unfollow', to: 'relationships#destroy', as: :unfollow
	get '/following_modal', to: 'relationships#following_modal', as: :following_modal
	get 'followers_modal', to: 'relationships#followers_modal', as: :followers_modal


	# sets root to signup page if not signed in or home page if signed in.
	devise_scope :user do
		authenticated :user do
			root 'posts#home'
		end

		unauthenticated do
			root 'devise/registrations#new'
		end
	end
end
