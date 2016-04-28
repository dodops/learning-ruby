Rails.application.routes.draw do
  # Rotas geradas pelo Devise, com adição do omniauth
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations" }

  resources :complaints

  get 'about' => 'home#about'
  get 'profile' => 'users#show'
  root 'home#index'

  # API definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show]
    end
  end

end
