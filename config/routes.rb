# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'repositories#index'

  resources :repositories, only: :index do
    collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
