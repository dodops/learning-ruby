Rails.application.routes.draw do
  # Rotas geradas pelo Devise, com adição do omniauth
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations" }

  resources :complaints

  get 'about' => 'home#about'
  root 'home#index'
end
