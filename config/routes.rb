Rails.application.routes.draw do
	devise_for :users
	resources :users, only: [:show]

	devise_scope :user do
		authenticated :user do
			root 'users#show'
		end

		unauthenticated do
			root 'devise/registrations#new'
		end
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
