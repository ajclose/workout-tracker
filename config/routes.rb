Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'signup' => 'users#new', as: :signup
  post 'signup' => 'users#create'

  get 'users/:id' => 'users#show', as: :user

end
