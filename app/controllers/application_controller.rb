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
  
  def logout!
    current_session.try(:destroy)
    session[:session_token] = nil
  end
  
  def require_signed_in
    redirect_to new_session_url unless signed_in?
  end
  
  def require_signed_out
    redirect_to albums_url if signed_in?
  end
  
  def require_permission_for(album)
    if album.owner != current_user && ((album.private_album?) ||
      (album.unlisted_album? && params[:auth_token] != album.auth_token))
       flash[:error] = "You do not have access to that page"
       redirect_to root_url #redirect back?
    end
  end

end
