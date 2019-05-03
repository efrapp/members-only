Rails.application.routes.draw do
  root 'users#new'
  get 'users/new'
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  get '/posts', to: 'posts#index'
  delete '/sign_out', to: 'sessions#delete'
  resources :users do
    resources :posts, only: [:new, :index, :create]
  end
  resources :sessions, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
