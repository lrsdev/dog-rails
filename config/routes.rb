Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :animals, only: [:index, :show]
  resources :reports, only: [:index, :show, :create]
  resources :locations, only: [:index, :show]
  resources :sync, only: [:index]
end
