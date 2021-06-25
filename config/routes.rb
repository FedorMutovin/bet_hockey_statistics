Rails.application.routes.draw do
  root to: 'accounts#index'
  resources :accounts, only: %i[index show]
  resources :transfers, only: :show
  resources :bets, only: :show
end
