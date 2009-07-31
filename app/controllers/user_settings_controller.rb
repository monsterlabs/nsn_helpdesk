class UserSettingsController < ApplicationController
  filter_access_to :all
  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render 'edit' }
    end    
  end

  def update
    @user = User.find(params[:id])
    @user.person_attributes.merge!(:modified_by_id => current_user.id)
    @user.address_attributes.merge!(:modified_by_id => current_user.id)
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_setting_path }
      else
        format.html { render 'edit' }
      end
    end    
  end

  def show
    @user = User.find(current_user.id)
    respond_to do |format|
      format.html {render 'show'}
    end
  end

end
