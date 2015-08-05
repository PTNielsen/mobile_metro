Rails.application.routes.draw do
  resources :transit, only: :index

  root 'transit#index'
end