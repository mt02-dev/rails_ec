# frozen_string_literal: true

Rails.application.routes.draw do
  delete 'carts/delete', to: 'carts#destroy'

  resources :tasks
  resources :carts
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :products
  end
  # Defines the root path route ("/")
  root 'products#index'
end
