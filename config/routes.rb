Rails.application.routes.draw do
  root to: 'accounts#index'
  resources :accounts, only: %i[index show]
  concern :operational do
    member do
      get :show
      post :create
    end
  end

  resources :bets, except: %i[show create index destroy new update edit], concerns: :operational
  resources :transfers, except: %i[show create index destroy new update edit], concerns: :operational
end
