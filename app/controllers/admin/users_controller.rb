class Admin::UsersController < ApplicationController
  def index
    @collection = User.find(:all, 
        :conditions => ['login <> ?', current_user.login],
        :include => :person,
        :order => "people.lastname #{params[:order] || 'ASC'}, people.firstname #{params[:order] || 'ASC'}"
      ).paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html { render 'new' }
      format.js { 
        @response_id = params[:response_id]
        @associated_field_id = params[:associated_field_id]
        @value_tag_id = params[:value_tag_id]
        render 'new_js' 
      }
    end
  end

  def create
    params[:user][:login] ||= params[:user][:email].split("@")[0]
    params[:user][:password] ||= "qw12.."
    params[:user][:password_confirmation] ||= "qw12.."
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to :action => 'index' }
        format.js { 
          @associated_field_id = params[:associated_field_id]
          @value_tag_id = params[:value_tag_id]
          render 'show_js' 
        }
      else
        format.html { render :action => 'new' }
        format.js { render 'error_js' }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    params[:user]['person_attributes'].merge!('modified_by_id' => current_user.id, 'ip_address' => request.remote_ip)
    params[:user]['address_attributes'].merge!('modified_by_id' => current_user.id, 'ip_address' => request.remote_ip)
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :action => 'index' }
        format.js {
          @associated_field_id = params[:associated_field_id]
          @value_tag_id = params[:value_tag_id]
          render 'users/show_js'
        }
      else
        format.html { render :action => 'new' }
        format.js { render 'error_js' }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render 'edit' }
      format.js {
        @associated_field_id = params[:associated_field_id]
        @value_tag_id = params[:value_tag_id]
        render 'edit_js' 
      }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render 'show' }
      format.js { 
        @associated_field_id = params['associated_field_id']
        @value_tag_id = params['value_tag_id']
        render 'show_js' 
      }
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
