Rails.application.routes.draw do
  resources :users, only: [:new, :index, :create, :show]
end
