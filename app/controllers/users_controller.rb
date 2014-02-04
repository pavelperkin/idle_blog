class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:update, :destroy, :make_admin]

  load_and_authorize_resource

  def index
    @users = User.all.reject {|u| u.admin?}
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: I18n.t('post.was_updated')
    else
      redirect_to users_path
    end
  end

  def make_admin
    @user.roles = [Role.find_by_name("admin")]
    @user.save and redirect_to users_path
  end

  def make_author
    @user.roles = [Role.find_by_name("author")]
    @user.save and redirect_to users_path
  end

  def make_reader
    @user.roles = [Role.find_by_name("reader")]
    @user.save and redirect_to users_path
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:post).permit(:body, :image, :header, :tag_list)
    end
end
