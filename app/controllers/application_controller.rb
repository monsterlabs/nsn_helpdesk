# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  # protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout nil

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  helper_method :current_user_session, :current_user
  before_filter :set_current_user
  # filter_parameter_logging :password, :password_confirmation
  # 
  #  private
  include AuthenticationSystem

  # Authorization with DeclarativeAuthorization
  def set_current_user
    Authorization.current_user = User.find(1)
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
