class SessionsController < ApplicationController
 # before_filter :require_no_user, :only => [:new, :create]
#  before_filter :require_user, :only => :destroy
  
  def new
    @session = UserSession.new
  end
  
  def create
    @session = UserSession.new(params[:user_session])
    if @session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default :controller => current_user.roles.first.name + '/tickets'
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
      u= User.find_by_email(params[:email])
      if u and u.send_random_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action => 'new'
      else
        flash[:warning]  = "Couldn't send password"
      end
    end
  end
end
