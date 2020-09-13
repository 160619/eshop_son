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

  get 'static_pages/home'
  devise_for :users
  root 'static_pages#home'
end
