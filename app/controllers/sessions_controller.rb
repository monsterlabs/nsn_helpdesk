class SessionsController < ApplicationController
#  skip_filter_access_to
  skip_before_filter :filter_access_filter
  skip_before_filter :require_user
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
      else
        flash[:warning]  = "Couldn't send password"
      end
      redirect_to :action => 'new'
    end
  end
end
