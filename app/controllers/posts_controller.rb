class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if params[:author]
      user = User.find_by_username (params[:author])
      @posts = user.posts.moderated.desc.paginate(page: params[:page])
    elsif params[:tag]
      @posts = Post.tagged_with(params[:tag]).moderated.desc.paginate(page: params[:page])
    else
      @posts = Post.moderated.desc.paginate(page: params[:page])
    end
  end

  def show
  end

  def for_moderation
    @posts = Post.waiting_for_moderation
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: I18n.t('post.was_created')
    else
      render action: 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: I18n.t('post.was_updated')
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, :image, :header, :tag_list, :moderated)
    end
end
