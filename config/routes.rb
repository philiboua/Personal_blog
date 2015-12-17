Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  get 'home/index'

  root to: 'home#index'
  resources :profiles
end
