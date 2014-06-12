class UsersController < ApplicationController

  def show
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
    @user = current_user
  end

  def update
    if @user.update(params.require(:user).permit(:username, :password))
      flash[:notice] = "Profile updated"
      redirect_to users_path(@user)
    else
      render :edit
    end
  end


end
