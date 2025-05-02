Rails.application.routes.draw do
  # Rutas RESTful estándar para los recursos (actualizadas)
  resources :users, only: [:index, :show, :new, :create]    # Añadido :new, :create
  resources :chats, only: [:index, :show, :new, :create]    # Añadido :new, :create
  resources :messages, only: [:index, :show, :new, :create] # Añadido :new, :create

  # Ruta para verificación de salud (se mantiene igual)
  get "up" => "rails/health#show", as: :rails_health_check

  # Ruta raíz (se mantiene igual)
  root 'users#index'
end