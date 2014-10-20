class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:update, :destroy, :make_admin]

  load_and_authorize_resource

  def index
    @users = User.all.reject {|u| u.admin?}
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

  def make_trusted
    @user.roles = [Role.find_by_name("trusted")]
    @user.save and redirect_to users_path
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
