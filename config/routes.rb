Rails.application.routes.draw do
  root to: 'accounts#index'
  resources :accounts, only: %i[index show]
  get 'show_operational/:id', to: 'operations#show_operational', as: :show_operational
  get 'create_operational', to: 'operations#create_operational'
end
