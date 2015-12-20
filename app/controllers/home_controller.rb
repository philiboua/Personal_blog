class HomeController < ApplicationController 

  layout 'visitor', only: [:about_me]
  before_action :blog_has_admin_user?, only: [:index]

  def index 
  end 

  def about_me 
    @profile = Profile.first
  end

  private 

  def blog_has_admin_user?
    if User.count == 1 
      redirect_to posts_path
    else
      render :index
    end
  end
  
end