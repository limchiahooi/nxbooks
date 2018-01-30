Rails.application.routes.draw do

  
  root "listings#index"

  resources :users do
  	resources :listings
  end


  resources :listings do
     resources :image, :only => [:create, :destroy] # support #create and #destroy
  end

  resources :listings do
       resources :comments, only: [:create, :destroy]
    end



  get    "/sign_in" => "sessions#new"
  post   "/sign_in" => "sessions#create"
  delete "/sign_out" => "sessions#destroy"
  get    "/sign_up" => "users#new"
  get    "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get    "/search" => "listings#search", as: "search"






end
