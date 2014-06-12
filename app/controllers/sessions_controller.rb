class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Login successful. Welcome, #{user.username}"
      redirect_to root_path
    else
      flash[:error] = "Cannot find username or password. Please try again"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out"
      redirect_to root_path
  end
end