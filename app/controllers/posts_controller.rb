class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments
    authorize! :read, @post
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
    render :new, locals: { post: @post }
  end

  # 
  def create
    authorize! :create, @post
    @user = User.find(params[:user_id])
    add_post = @user.posts.new(post_params)
    add_post.comments_counter = 0
    add_post.likes_counter = 0
    respond_to do |format|
      format.html do
        if add_post.save
          flash[:success] = 'Post created successfully'
          redirect_to user_posts_url
        else
          flash.now[:error] = 'Error: Post could not be created'
          render :new, locals: { post: add_post }
        end
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    authorize! :read, @post

    flash[:success] = 'Post deleted successfully'
    redirect_to root_url
  end

  private

  # def post_params
  #   params.require(:data).permit(:title, :text)
  # end
  def post_params
    params.require(:new_post).permit(:title, :text)
  end
end
