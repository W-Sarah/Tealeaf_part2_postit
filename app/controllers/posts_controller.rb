class PostsController < ApplicationController
before_action :set_post, only: [:show, :edit, :update, :vote]
before_action :require_login, except: [:show, :index]
before_action :require_admin_or_creator, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "Post successfully edited"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def require_admin_or_creator
    unless logged_in? and (current_user.id == @post.user_id or current_user.admin?)
      access_denied
    end
  end

  def vote
    @vote = Vote.create(user_id: current_user.id, voteable_type: "Post", voteable_id: @post.id, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Thanks for voting."
        else
          flash[:error] = "You can only vote on a post once"
        end
        redirect_to :back
      end
      format.js do
        format.js
      end
    end

  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

end
