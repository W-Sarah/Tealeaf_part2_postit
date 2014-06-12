class UsersController < ApplicationController


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

end
