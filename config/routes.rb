Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}

  #root page 
  root to: 'home#index'

  #static page
  get 'home/get_started'
  get 'home/resume'
  get 'home/index'
  get 'home/test'
  get 'home/about_me'
  get 'home/contact'
  get 'posts/manage_posts'
  get 'apps/my_apps'

  get 'websites/cocoa_latte'

  
  resources :profiles
  resources :posts

  resources :apps, except: [:show]
  

end
