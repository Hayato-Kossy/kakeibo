Rails.application.routes.draw do
  root "books#index"
  resources :books, except: :destroy
  delete '/books/:id', to: 'books#destroy', as: 'destroy_book'  
end
