Rails.application.routes.draw do
  devise_for :users
  root 'dashboards#index'

  resources :dashboards, only: [] do
    collection do
      get :income_amount
      get :expense_amount
      get :cashflow_data
    end
  end
  resources :transactions
  resources :categories
  resources :wallets
end
