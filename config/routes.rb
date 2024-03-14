# frozen_string_literal: true

Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/create'
  delete 'carts/delete', to: 'carts#destroy'
  resources :tasks
  resources :products
  resources :carts, only: %i[index create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :orders only: %i[index create]

  namespace :admin do
    resources :products
  end
  # Defines the root path route ("/")
  root 'products#index'
end
