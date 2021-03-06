Rails.application.routes.draw do
  get '/', to: 'home#home'
  resources :users, only: [:new, :index, :create, :show]
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  namespace :admin do
    resources :categories
  end

  resources :favourites, only: [:create, :destroy]

  resources :gifs, only: [:index, :destroy]
end
