class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :signed_in?
  
  def current_user
    @current_user ||= current_session.try(:user)
  end

  def current_session
    Session.find_by_session_token(session[:session_token])
  end
  
  def signed_in?
    !!current_user
  end

  def login!(user)
    new_session = user.sessions.create!
    @current_user = user
    flash[:notice] = "Welcome #{user.name}!"
    session[:session_token] = new_session.session_token
  end

end
