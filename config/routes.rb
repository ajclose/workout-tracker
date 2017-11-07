Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'workouts#index'

  get 'signup' => 'users#new', as: :signup
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: :logout
  get 'weight-calculator' => 'weight_calculator#index'
  get 'amraps' => 'amraps#index'
  get 'roundsfortime' => 'rfts#index'

  resources :users, except: [:index, :new, :create]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :workouts do
    resources :amraps
    resources :rfts
    resources :strengths
  end

  resources :amraps do
    resources :amrapmovements
  end

  resources :rfts do
    resources :rftmovements
  end
end
