Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'users#index'

  get 'signup' => 'users#new', as: :signup
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: :logout

  resources :users, except: [:index, :new, :create]
  resources :account_activations, only: [:edit]

end
