Rails.application.routes.draw do

  
  root "listings#index"

  resources :users do
  	resources :listings
  end

  resources :users do
    resources :comments
  end


  resources :listings do
     resources :image, :only => [:create, :destroy] # support #create and #destroy
  end

  resources :listings do
       resources :comments
    end

  resources :comments



  get    "/sign_in" => "sessions#new"
  post   "/sign_in" => "sessions#create"
  delete "/sign_out" => "sessions#destroy"
  get    "/sign_up" => "users#new"
  get    "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get    "/search" => "listings#search", as: "search"
  get    "/api" => "static#api"

  map.connect '*path', :controller => 'static', :action => 'error'






end
