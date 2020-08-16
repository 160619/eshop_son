# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories, only: %i[index new create]
  resources :products, only: %i[index new create]
end
