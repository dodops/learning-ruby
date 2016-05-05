Rails.application.routes.draw do

  # API definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :complaints, only: [:show, :index]
    end
  end

  # Rotas geradas pelo Devise, com adição do omniauth
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations" }

  resources :complaints

  get 'about' => 'home#about'
  get 'profile' => 'users#show'
  root 'home#index'

end
