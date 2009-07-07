class UserSettingsController < ApplicationController
  filter_access_to :all
  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {render 'edit'}
    end    

  end

  def update
    respond_to do |format|
      format.html {render :text => "Update"}
    end    
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html {render 'show'}
    end
  end

end
