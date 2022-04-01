class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(params)
    @comment.post_id = params[:post_id]
    if new_comment.save
      new_comment.update_comments_counter
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", notice: 'Success!'
    else
      render :new, alert: 'Error occured!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end