class PostsController < ApplicationController
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
    @post = Post.new
  end

  def create
    new_post = current_user.posts.new(post_params)
    new_post.likes_counter = 0
    new_post.comments_counter = 0
    new_post.update_posts_counter
    respond_to do |format|
      format.html do
        if new_post.save
          redirect_to "/users/#{new_post.user.id}/posts/", flash: { alert: 'Success!' }
        else
          render :new, flash: { alert: 'Error occured!' }
        end
      end
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    post.author.decrement!(:posts_counter)
    post.destroy
    flash[:notice] = 'Post was removed successfully!'
    splitted_path = params[:url].split('/')
    splitted_path.pop if splitted_path.length == 7 # If the user removed the post while being on its page
    redirect_to params[:url]
  end

  private

  def post_params
    params.require(:data).permit(:title, :text)
  end
end
