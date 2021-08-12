Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, only: %i[index show]
  resources :accounts, only: :show
  concern :operational do
    member { get :show }
    collection { post :create }
  end

  resources :bets, except: %i[show create index destroy new update edit], concerns: :operational
  resources :transfers, except: %i[show create index destroy new update edit], concerns: :operational

  get 'search_data', to: 'bets#search_data'
end
