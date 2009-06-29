class Admin::UsersController < ApplicationController

  def index
    @collection = User.all

    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html { render 'new' }
    end
  end

  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to :action => 'index' }
      else
        format.html { render :action => 'new' }        
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html { render 'edit' }
    end
  end

  def delete
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.js { render 'delete.rjs' }
    end    
  end

end
