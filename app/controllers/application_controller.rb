class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # choose which methods should be available in application views as well
  helper_method :current_user, :logged_in?

  def current_user
    # return the current (retrieved) user or retrieve the user from DB
    @current_user ||= Expert.find(session[:expert_id]) if session[:expert_id]
  end

  def logged_in?
    # convert the result into a boolean
    !!current_user
  end

  def require_user
    # this method is used to restrict actions from non logged in users
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
