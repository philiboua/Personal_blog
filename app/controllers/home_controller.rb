class HomeController < ApplicationController 

  layout 'visitor', only: [:about_me, :contact]
  before_action :blog_has_admin_user?, only: [:index]

  def index 
  end 

  def about_me 
    @profile = Profile.first
  end

  def contact
  end

  def get_started
  end

  private 

  def blog_has_admin_user?
    if User.count == 1 
      render :index
    else
      render :get_started
    end
  end
  
end