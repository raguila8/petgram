Rails.application.routes.draw do
	devise_for :users, skip: [:sessions, :registrations]
	devise_scope :user do
		get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
		post 'sign_in', to: 'devise/sessions#create', as: :user_session
  	delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
		get 'cancel_registration', to: 'registrations#cancel', as: :cancel_user_registration
		get 'sign_up', to: 'registrations#new', as: :new_user_registration
		get 'change_password', to: 'registrations#edit', as: :edit_user_registration
		patch '/change_password', to: 'registrations#update', as: :update_edit_user_registration
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
	resources :profiles, only: [:show, :edit, :new] do 
		member do
			patch 'edit', action: :update, :as => :update_edit
		end
	end
	post '/profiles/new', to: 'profiles#create', as: :update_new_profile

	#patch '/profiles/:id/edit' => 'profiles#update'

	devise_scope :user do
		authenticated :user do
			root 'profiles#show'
		end

		unauthenticated do
			root 'devise/registrations#new'
		end
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
