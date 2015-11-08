Rails.application.routes.draw do
  get '/', to: 'home#home'
  resources :users, only: [:new, :index, :create, :show]
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'

  resources :gifs, only: [:index]
end
