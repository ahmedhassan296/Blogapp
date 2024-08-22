Rails.application.routes.draw do
  # Devise routes for admin and users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Root path
  root to: 'home#index'

  # Sign out route for users (Devise)
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # Posts and nested resources (comments, likes)
  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # Moderator-specific actions on posts
  namespace :moderators do
    resources :posts, only: [] do
      collection do
        patch 'approve'
        delete 'delete_reported'
      end
      member do
        patch 'approve'
        delete 'delete_reported'
      end
    end

    # Dashboard for moderators
    get 'welcome', to: 'welcome#index', as: 'moderator_dashboard'
  end

  # Health check endpoint
  get 'up' => 'rails/health#show', as: :rails_health_check
end
