# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  namespace :admin do
    namespace :center do
      get 'index', to: 'center#index'
      resources :users, controller: 'users'
    end
  end
end
