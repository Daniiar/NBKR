# frozen_string_literal: true

Rails.application.routes.draw do
  root 'rates#main_page'
  get 'search_rates_by_dates_and_currency', to: 'rates#search_rates_by_dates_and_currency'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
