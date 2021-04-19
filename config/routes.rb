Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :transactions, only: %w[create] do
    get :withdraw, on: :collection
    get :deposit, on: :collection
  end

  resources :users, only: [] do
    get :profile, on: :collection
    post :update_profile, on: :collection
    get :change_password, on: :collection
    post :update_password, on: :collection
  end

  namespace :dashboard do
    root to: 'pages#home'
    resources :users, only: %w[index edit update]
    resources :transactions, only: %w[index] do
      patch :update_status, on: :member
    end
  end
end
