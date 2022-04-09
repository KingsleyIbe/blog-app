class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    post = Post.find(params[:id])
    comment = post.comments.create(comment_params)
    comment.author_id = current_user.id
    comment.save
    if comment.save
      flash[:success] = 'Your comment was created'
      redirect_to user_post_path(post.author_id, post.id)
    else
      flash[:error] = 'Your comment was not added'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:success] = 'Your comment was deleted'
    redirect_to root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
