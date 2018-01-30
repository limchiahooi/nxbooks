Rails.application.routes.draw do

  
  root "static#index"

  resources :users do
  	resources :listings
  end



  get    "/sign_in" => "sessions#new"
  post   "/sign_in" => "sessions#create"
  delete "/sign_out" => "sessions#destroy"
  get    "/sign_up" => "users#new"
  get    "/auth/:provider/callback" => "sessions#create_from_omniauth"






end
