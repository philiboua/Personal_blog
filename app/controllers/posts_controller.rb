class PostsController < ApplicationController 


  layout :visitor_or_admin?
  before_action :authenticate_user!, except: [:show, :index]
  respond_to :html, :js

  def new 
    @post = Post.new
  end

  def create 
    @post = Post.new(post_params)
    if @post.save 
      redirect_to @post
    else
      render :new 
    end
  end

  def index 
    @posts = Post.paginate(:page => params[:page], :per_page => 6)
  end

  def show 
    @post = Post.friendly.find(params[:id])
  end

  def edit 
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.friendly.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to @post 
    else
      render :edit 
    end
  end

  def manage_posts
   @posts = Post.paginate(:page => params[:page], :per_page => 6)
  end

  def destroy 
    @post = Post.friendly.find(params[:id])
    if @post.destroy 
      flash[:notice] = "the post has been deleted"
    else 
      flash[:error] = "An error occured, please try again"
    end
    respond_with(@post) do |f|
      f.html { redirect_to :back }
    end
  end

  private 

  def post_params
    params.require(:post).permit(:title, :image, :body, :slug)
  end

  def visitor_or_admin?
    case action_name 
      when "show", "index"
      "visitor"
      else
      "admin"
    end
  end

  


end