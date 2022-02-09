Rails.application.routes.draw do
  devise_for :users
  root 'dashboards#index'

  resources :transactions
  resources :categories
  resources :wallets
end
