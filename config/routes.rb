Rails.application.routes.draw do

  devise_for :users, controllers: {
  passwords: 'passwords',
  sessions: 'sessions',
  registrations: 'registrations'
  }

  resources :users do
    resources :chats, only: [:index]
  end

  resources :chats do
    resources :messages
  end

  # Opcional: ruta alternativa para logout
  delete '/logout', to: 'sessions#destroy', as: :logout

  root 'users#index'
end