Rails.application.routes.draw do
  devise_for :users
  root to: 'users#profile'
  resources :users, only: %i[profile]
  resources :accounts, only: %i[show create destroy]
  concern :operational do
    member { get :show }
    collection { post :create }
  end

  resources :bets, except: %i[show create index destroy new update edit], concerns: :operational
  resources :transfers, except: %i[show create index destroy new update edit], concerns: :operational

  get 'search_data', to: 'bets#search_data'
end
