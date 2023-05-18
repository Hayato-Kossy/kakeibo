Rails.application.routes.draw do
  resources :books
  root "books#index"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create" 

  get "/users/edit", to: "users#edit", as: "edit_user"
  patch "/users", to: "users#update", as: "user"
  
  get "/signin", to: "session#new"
  post "/signin", to: "session#create"

  get "/signout", to: "session#destroy"

end