# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories, only: %i[index new create]
  resources :products do
    resources :reviews
  end

  resources :reviews do
    resources :comments
  end

  namespace :admin do
    root 'static_pages#index'
    resources :categories
    resources :products
    resources :reviews
    resources :comments
    resources :users, only: [:index]
  end

  get 'static_pages/home'
  devise_for :users
  root 'static_pages#home'
end
