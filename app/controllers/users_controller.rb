class UsersController < ApplicationController
  before_action :require_same_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]


  def show
    end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password, :time_zone))

    if @user.save
      flash[:notice] = "You successfully registered"
      redirect_to root_path
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(params.require(:user).permit(:username, :password, :time_zone))
      flash[:notice] = "Profile updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def set_user
    @user = User.find_by slug: params[:id]
  end


  private
    def require_same_user
    unless current_user != @user
      flash[:error] = "You can't perform this action"
      redirect_to root_path
    end
  end


end
