Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
   # get 'admin/index', to: 'admin#index', as: 'admin_dashboard'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
      registrations: 'users/registrations'

  }

  resources :posts do
      resources :comments, only: [:create]
  end

resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

   devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

 namespace :moderators do
    resources :posts, only: [] do
      member do
        patch 'approve'
        delete 'delete_reported'
      end
      collection do
        delete 'delete_reported'
      end
       collection do
        patch 'approve'
      end
    end

    get 'welcome', to: 'welcome#index', as: 'moderator_dashboard'
    
  end
  

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check


end
