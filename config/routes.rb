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
  get "/documents/loading", to: "documents#loading"
  get "/users/dashboard", to: "users#dashboard"
  get '/documents/download_csv', to: 'documents#download_csv', as: 'download_csv_your_controller'
  resources :documents
  
  root "users#home"
end
