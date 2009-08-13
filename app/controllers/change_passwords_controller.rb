class ChangePasswordsController < ApplicationController

  def edit
    @user = User.find(current_user.id)
    flash[:notice] = ""
    render
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user]) and @user.errors.first.nil?
      flash[:notice] = 'Your password has been changed!'
      render :action => 'edit'
    else  
      flash[:notice] = ""
      render :action => 'edit'
    end    
  end
  
end
