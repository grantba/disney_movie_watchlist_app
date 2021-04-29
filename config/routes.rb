Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/search_by_name', to: 'movies#search_by_name'
  post '/search_by_id', to: 'movies#search_by_id'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :movies, only: [:show] do
    resources :reviews, only: [:create]
  end
 
  resources :movies, only: [:index, :show, :destroy]

  resources :users, only: [:show] do
    resources :reviews, :watchlists, only: [:index, :show]
  end

  resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  resources :watchlists, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only: [:new, :create, :edit, :update, :destroy]

  root 'users#home'

end
