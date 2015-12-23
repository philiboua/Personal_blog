class AppsController < ApplicationController

  before_action :authenticate_user!, except: :index
  layout :visitor_or_admin?
  respond_to :html, :js


  def new 
    @app = App.new 
  end

  def create 
    @app = App.new(app_params)
    if @app.save
      redirect_to apps_path
    else
      render :new
    end
  end

  def edit 
    @app = App.find(params[:id])
  end

  def update 
    @app = App.find(params[:id])
    if @app.update_attributes(app_params)
      redirect_to apps_path
    else
      render :edit
    end
  end

  def index
    @apps = App.paginate(:page => params[:page], :per_page => 6)
  end

  def my_apps
     @apps = App.paginate(:page => params[:page], :per_page => 6)
  end

  def destroy 
    @app = App.find(params[:id])
    if @app.destroy 
      flash[:notice] = "Your app has been deleted"
    else 
      flash[:error] = "An error occured, please try again"
    end
    respond_with(@app) do |f|
      f.html { redirect_to :back }
    end
  end

  private 

  def app_params
    params.require(:app).permit(:name, :screenshot, :content, :website, :repository ) 
  end

  def visitor_or_admin?
    case action_name 
      when "index"
      "visitor"
      else
      "admin"
    end
  end

end