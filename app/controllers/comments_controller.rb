class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(comment_params)
    # comment.user_id = current_user.id
    comment.save
    flash[:success] = 'Your comment was created'
    redirect_to root_url
  end
    # comment = current_user.comments.new(comment_params)
  #   comment.post = post
  #   if comment.save!
  #     flash[:success] = 'Your comment was added'
  #   else
  #     flash[:error] = 'Your comment was not added'
  #   end
  #   redirect_to user_post_path
  # end

  def destroy
    @comment = Comment.find(params[:post_id])
    @comment.destroy
    flash[:success] = 'Your comment was deleted'
    redirect_to root_url
  end

  private

  def comment_params
    params.permit(:text)
  end
end
