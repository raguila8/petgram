Rails.application.routes.draw do
  resources :posts
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
=begin
		cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
   new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
       user_registration PATCH  /users(.:format)               devise/registrations#update
                         PUT    /users(.:format)               devise/registrations#update
                         DELETE /users(.:format)               devise/registrations#destroy
                         POST   /users(.:format)               devise/registrations#create

		#get 'new_password', to: 'devise/passwords#new', as: :new_user_password
		#get 'edit_password', to: 'devise/passwords#edit', as: :edit_user_password
		#patch '/user/password', to: 'devise/passwords#update', as: :user_password
		#put '/user/password', to: 'devise/passwords#update'
		#post '/user/password', to: 'devise/passwords#create'
=end
	end
	#devise_for :users

	resources :users, only: [:show]
	resources :profiles, only: [:show, :edit, :new, :destroy] do 
		member do
			patch 'edit', action: :update, :as => :update_edit
		end
	end
	post '/profiles/new', to: 'profiles#create', as: :update_new_profile
	get '/delete_profiles', to: 'users#delete', as: :delete_profiles

	get '/home', to: 'posts#home', as: :home
	post '/comments', to: 'comments#create', as: :comments
	delete '/comments', to: 'comments#destroy', as: :destroy_comment
	get '/get_comments', to: 'comments#get_comments', as: :get_comments
	get '/autocomplete', to: 'profiles#autocomplete', as: :autocomplete
	get '/vote', to: 'posts#vote', as: :vote
	get '/discover', to: 'profiles#discover', as: :discover
	get '/post_modal', to: 'posts#post_modal', as: :post_modal
	get '/get_modal_comments', to: 'comments#get_modal_comments', as: :get_modal_comments
	post '/modal_comments', to: 'comments#create_modal_comment', as: :modal_comments
	patch '/update_profile_img', to: 'profiles#update_profile_image', as: :update_profile_image
	post '/follow', to: 'relationships#create', as: :follow
	get '/unfollow', to: 'relationships#destroy', as: :unfollow
	get '/following_modal', to: 'relationships#following_modal', as: :following_modal
	get 'followers_modal', to: 'relationships#followers_modal', as: :followers_modal
	get '/post_settings_modal', to: 'posts#open_post_settings_modal', as: :post_settings_modal
	get '/read_notifications', to: 'profiles#read_notifications', as: :read_notifications
	get '/welcome/:id', to: 'profiles#welcome', as: :welcome
	get '/set_pet_type', to: 'profiles#set_pet_type', as: :set_pet_type
	patch '/edit_pet_type', to: 'profiles#edit_pet_type', as: :edit_pet_type
	get '/change_profile', to: 'profiles#change_profile', as: :change_profile

	#patch '/profiles/:id/edit' => 'profiles#update'

	devise_scope :user do
		authenticated :user do
			root 'posts#home'
		end

		unauthenticated do
			root 'devise/registrations#new'
		end
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
