class ChangePasswordsController < ApplicationController

  def edit
     @user = User.find(current_user.id)
    render
  end

  def update
    @user = User.find(current_user.id)
    
    if @user.update_attributes(params[:user]) and @user.errors.first.nil?
      redirect_to :controller => current_user.roles.first.name + '/tickets', :action => 'index'
    else  
      render :action => 'edit'
    end    
  end
  
end
