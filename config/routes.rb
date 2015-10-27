Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :animals, only: [:index, :show]
  resources :reports, only: [:index, :show, :create]
  resources :locations, only: [:index, :show] do
    resources :dog_statuses, only: [:index, :show]
  end
  resources :sync, only: [:index]
  root to: "admin/dashboard#index"
end
