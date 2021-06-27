Rails.application.routes.draw do
  root to: 'accounts#index'
  resources :accounts, only: %i[index show]
  concern :operational do
    member do
      get :show
      post :create
    end
  end

  resources :bets, only: %i[show create], concerns: :operational do
    member do
      get :odds
    end
  end
  resources :transfers, only: %i[show create], concerns: :operational
end
