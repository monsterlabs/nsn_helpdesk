class Admin::UsersController < ApplicationController
  filter_access_to :all
  def index
    @collection = User.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
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

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
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

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render 'show' }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
     end    
  end

end
