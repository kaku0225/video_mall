# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :users
  namespace :admin do
    namespace :center do
      get 'index', to: 'center#index'
    end
  end
end
