class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :sign_in_user!

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def sign_out(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def ensure_signed_in
    redirect_to new_session_url unless signed_in?
  end
end
