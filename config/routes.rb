Rails.application.routes.draw do
  resources :users
  
  resources :chats
  resources :messages

  get "up" => "rails/health#show", as: :rails_health_check
  root 'users#index'
end