class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = User.find(params[:user_id]).posts.includes(:comments).find(params[:id])
    authorize! :read, @post
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
    render :new, locals: { post: @post }
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_posts_url
    else
      render :new, locals: { post: @post }
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    authorize! :read, @post

    flash[:success] = 'Post deleted successfully'
    redirect_to user_posts_url
  end

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text)
  end
end
