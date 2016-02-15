Rails.application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  resources :sessions
  get "signup" => "users#new", :as => "signup"
  # resources :sessions
  root 'reports#index'
  get "search_yelp" => "support#search_yelp"
  get "search_city" => "support#search_city"

  resources :cities
  resources :spots
  resources :reports
  resources :users
end
