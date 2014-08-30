class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :require_login

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to perform this action"
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user.admin? and logged_in?
      access_denied
    end
  end


  def access_denied
    flash[:error] = "You cannot perform this action"
      redirect_to root_path
  end

end
