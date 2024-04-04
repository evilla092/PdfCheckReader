Rails.application.routes.draw do
  resources :infractions
  resources :payers
  resources :checks
  resources :employers,except: [:edit, :update, :destroy]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/documents/survey", to: "documents#survey"
  resources :documents
  
  root "users#home"
end
