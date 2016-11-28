Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'notifications#index'

  resources :notifications
  resources :notifications, only: [:create, :index]
end
