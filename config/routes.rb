Rails.application.routes.draw do
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
  # get '/users/profile', to: 'users#profile', as: :user_profile
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
end
