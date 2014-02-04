class CommentsController < ApplicationController
  respond_to :js
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  load_and_authorize_resource

  def create
    @comment = current_user.comments.create(comment_params)
  end

  def destroy
    Comment.find(params[:id]).destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
