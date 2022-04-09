# class LikesController < ApplicationController
#   load_and_authorize_resource

#   def create
#     @post = Post.find(params[:post_id])
#     new_like = current_user.likes.new(
#       author_id: current_user.id,
#       post_id: @post.id
#     )
#     if new_like.save
#       redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash: { alert: 'Your like is saved' }
#     else
#       redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash.now[:error] = 'Could not save like'
#     end
#   end
# end

class LikesController < ApplicationController
  load_and_authorize_resource

  def create
    post = Post.find(params[:id])
    like = current_user.likes.create(post:)
    if like.save!
      flash[:success] = 'like added'
    else
      flash[:error] = 'like was not added'
    end
    redirect_to user_post_path(@post)
  end
end
