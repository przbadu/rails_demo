Rails.application.routes.draw do
  resources :transactions
  resources :categories
  resources :wallets
  devise_for :users
  root 'dashboards#index'
end
