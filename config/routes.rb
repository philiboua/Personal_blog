Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}

  get 'home/index'
  get 'home/test'
  get 'home/about_me'

  get 'posts/manage_posts'

  root to: 'home#index'
  resources :profiles
  resources :posts

end
