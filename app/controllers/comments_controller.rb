class CommentsController < ApplicationController
  respond_to :js
  load_and_authorize_resource

  def create
    @comment = current_user.comments.create(comment_params)
    @post = @comment.post
  end

  def destroy
    comment = Comment.find(params[:id])
    @post = comment.post
    comment.destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
