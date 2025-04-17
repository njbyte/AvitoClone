class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def require_login
    unless authenticated?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path # or new_session_path
    end
  end
end
