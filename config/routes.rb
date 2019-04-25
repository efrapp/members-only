Rails.application.routes.draw do
  root 'users#new'
  get 'users/new'
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  resources :users
  resources :sessions, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
