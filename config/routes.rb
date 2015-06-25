Rails.application.routes.draw do
  resources :transit, only: [:index, :show]

  root 'transit#index'
end