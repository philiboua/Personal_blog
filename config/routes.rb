Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}

  #root page 
  root to: 'home#index'

  #static page
  get 'home/index'
  get 'home/test'
  get 'home/about_me'
  get 'posts/manage_posts'
  get 'apps/my_apps'

  
  resources :profiles
  resources :posts
  resources :apps, except: [:show]
  

end
