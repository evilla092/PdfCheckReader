Rails.application.routes.draw do
  resources :infractions
  resources :payers
  resources :checks
  # Nitpick: add a spacing after the comma between ``:employers, except:``
  resources :employers,except: [:edit, :update, :destroy]
  devise_for :users
  # Remove the unnecessary default comments on lines 8, 10, & 11
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/documents/survey", to: "documents#survey"
  get "/documents/loading", to: "documents#loading"
  get "/users/dashboard", to: "users#dashboard", as: "dashboard"
  get '/documents/download_csv', to: 'documents#download_csv', as: 'download_csv'
  resources :documents

  root "users#home"
end
