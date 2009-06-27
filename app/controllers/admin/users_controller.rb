class Admin::UsersController < ApplicationController

  def index
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end

  def new
    @user = User.new
#    @person = Person.new

    respond_to do |format|
      format.html { render 'new' }
    end
  end

  def create
    @user = User.new
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to :action => 'index' }
      else
        format.html { redirect_to :action => 'new' }        
      end
    end
  end

end
