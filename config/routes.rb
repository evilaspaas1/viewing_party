Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"


  get "/register", to: "users#new"
  post "/register", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :dashboard, only: [:index]

  resources :discover, only: [:index]

  resources :movies, only: [:index, :show]

  resources :viewing_party, only: [:new, :create]

end
