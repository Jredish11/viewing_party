Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'dashboard#index'

  get '/register', to: 'users#new'
  
  

  
  resources :users, only: [:show, :create] do
    get '/discover', to: 'users/discover#index'
    get '/movies', to: 'users/movies#index'
    get '/movies/:id', to: 'users/movies#show', as: 'movie'
    get '/movies/:id/viewing_party/new', to: 'users/viewing_party#new', as: 'viewing_party'
    post '/movies/:id/viewing_party/new', to: 'users/viewing_party#create', as: 'new_viewing_party'
  end
end

