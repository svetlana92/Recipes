Rails.application.routes.draw do

  devise_for :users
  resources :users, except: [:new, :create]

  resources :recipes

  resources :categories, only: [:show, :index]

  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
