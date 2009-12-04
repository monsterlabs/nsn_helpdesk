class SessionsController < ApplicationController
  include SslRequirement
  skip_before_filter :filter_access_filter
  skip_before_filter :require_user

  ssl_required :create, :new, :recover_password if RAILS_ENV == "production"
  caches_action :new, :recover_password

  def new
    @session = UserSession.new
  end
  
  def create
    @session = UserSession.new(params[:user_session])
    if @session.save
      flash[:notice] = "Login successful!"
      redirect_to :controller => current_user.role_symbols.first.to_s + '/tickets',  :protocol => 'http'
    else
      render 'new'
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_session_url
  end
  
  def recover_password
    if request.post?
      u = User.find_by_email(params[:email])
      if u and u.send_random_password
        flash[:message]  = "A new password has been sent by email."
      else
        flash[:warning]  = "Couldn't send password"
      end
      @session = UserSession.new
      render :action => 'new'
    end
  end
end
