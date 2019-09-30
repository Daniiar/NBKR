# frozen_string_literal: true

Rails.application.routes.draw do
  get 'search', to: 'rates#search'
  root 'rates#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
