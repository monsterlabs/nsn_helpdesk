class UserSettingsController < ApplicationController

  def edit
    respond_to do |format|
      format.html {render :text => "Edit"}
    end    
  end
  
  def update
    respond_to do |format|
      format.html {render :text => "Update"}
    end    
  end
  
  def show
    respond_to do |format|
      format.html {render :text => "Show"}
    end
  end
  
end
