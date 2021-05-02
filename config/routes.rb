Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/search_by_name', to: 'movies#search_by_name'
  post '/search_by_id', to: 'movies#search_by_id'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/homepage' => 'users#show'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :movies, only: [:show] do
    resources :reviews, only: [:create]
  end
 
  resources :movies, only: [:index, :show, :destroy]

  resources :users, only: [:show] do
    resources :reviews, only: [:index, :edit, :new]
  end

  resources :users, only: [:show] do
    resources :watchlists, only: [:index, :show, :edit, :new]
  end

  resources :reviews, only: [:create, :update, :destroy]
  resources :watchlists, only: [:create, :update, :destroy]
  resources :users, only: [:new, :create, :edit, :update, :destroy]

  root 'users#show'

end
