Rails.application.routes.draw do

  root 'reports#index'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  post "login" => "sessions#create"
  get "signup" => "users#new", :as => "signup"

  resources :reports, only: [:index, :show, :new, :create, :edit, :update, :delete]
  resources :users, only: [:index, :show, :new, :create, :edit, :update]

  get "users/:id/edit_password" => "users#edit_password", :as => "edit_password"
  patch "users/:id/update_password" => "users#update_password", :as => "update_password"

  get "search_yelp" => "support#search_yelp"
  get "search_city" => "support#search_city"

end
