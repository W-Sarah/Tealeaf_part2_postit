class UsersController < ApplicationController
  before_action :require_same_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password))

    if @user.save
      flash[:notice] = "You successfully registered"
      redirect_to root_path
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(params.require(:user).permit(:username, :password))
      flash[:notice] = "Profile updated"
      redirect_to users_path(@user)
    else
      render :edit
    end
  end

  private
    def require_same_user
    unless current_user = @user
      flash[:error] = "You can't perform this action"
      redirect_to root_path
    end
  end


end
