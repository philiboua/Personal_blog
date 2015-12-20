class PostsController < ApplicationController 


  layout :visitor_or_admin?
  before_action :authenticate_user!, except: [:show, :index]

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
    @posts = Post.all 
  end

  def show 
    @post = Post.find(params[:id])
  end

  def edit 
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to @post 
    else
      render :edit 
    end
  end

  def manage_posts
    @posts = Post.all
  end

  private 

  def post_params
    params.require(:post).permit(:title, :image, :body)
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