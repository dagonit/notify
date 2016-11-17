Rails.application.routes.draw do
  resources :notifications
  resources :notifications, only: [:create, :index]
end
