Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  get 'home/index'
  get 'home/test'

  root to: 'home#index'
  resources :profiles
end
