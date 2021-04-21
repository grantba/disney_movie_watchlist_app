Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/search_by_name', to: 'movies#search_by_name'
  post '/search_by_id', to: 'movies#search_by_id'
 
  resources :movies 
  resources :reviews
  resources :users
  resources :watchlists

  root 'movies#index'

end
