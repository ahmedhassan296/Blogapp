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

  # Posts and nested resources (comments, likes)
  resources :posts do
    resources :comments do
      resources :likes, only: [:create, :destroy], as: 'comment_likes'
    end
    resources :likes, only: [:create, :destroy]
  end
  resources :reports, only: [:create]

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
