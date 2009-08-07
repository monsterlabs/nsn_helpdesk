class PasswordResetsController < ApplicationController

  def edit
    render
  end

  def update
    @user = User.find_using_perishable_token(current_user.perishable_token)
    
    if @user.update_attributes(params[:user])  
      redirect_to :controller => current_user.roles.first.name + '/tickets', :action => 'index'
    else  
      render :action => 'edit'
    end    
  end
  
end
