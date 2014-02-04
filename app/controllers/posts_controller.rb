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
      @posts = user.posts.desc.paginate(page: params[:page])
    elsif params[:tag]
      @posts = Post.tagged_with(params[:tag]).desc.paginate(page: params[:page])
    else
      @posts = Post.desc.paginate(page: params[:page])
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: I18n.t('post.was_created') }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: I18n.t('post.was_updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, :image, :header, :tag_list)
    end
end
