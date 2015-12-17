class ProfilesController < ApplicationController 

  before_action :authenticate_user!

  def new
    @profile = Profile.new
  end

  def create 
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to root_path
    else
      render :new
    end
  end

  private 

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :blog_title, :photo, :about_me)
  end
  
end 