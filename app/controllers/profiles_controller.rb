class ProfilesController < ApplicationController 

  before_action :authenticate_user!
  layout 'admin', except: :new

  def new
    @profile = Profile.new
  end

  def show 
    @profile = Profile.find(params[:id])
  end

  def create 
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to @profile 
    else
      render :new, layout: "application"
    end
  end

  def edit 
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(profile_params)
      redirect_to @profile 
    else
      render :edit 
    end
  end

  private 

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :blog_title, :photo, :about_me)
  end
  
end 