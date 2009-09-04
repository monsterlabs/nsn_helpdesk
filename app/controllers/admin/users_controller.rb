class Admin::UsersController < ApplicationController
  def index
    conditions_str = 'login <> ? AND (people.lastname like ? OR people.firstname like ?)'
    conditions_vals = [current_user.login, "%#{params[:filter] || ""}%", "%#{params[:filter] || ""}%"]
    if params[:role] && !params[:role][0].blank?
      conditions_str += ' AND roles.id = ?'
      conditions_vals << params[:role]
    end
    if params[:region] && !params[:region][0].blank?
      conditions_str += ' AND region_id = ?'
      conditions_vals << params[:region]
    end
    @collection = User.find(:all, 
        :conditions => [ conditions_str, *conditions_vals ],
        :include => [:person, :roles],
        :order => "people.lastname #{params[:order] || 'ASC'}, people.firstname #{params[:order] || 'ASC'}"
      ).paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    respond_to do |format|
      format.html { render :action => 'index' }
      # format.js { render 'users/list_js' }
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
          @response_id = params[:response_id]
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
        @response_id = params[:response_id]
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
        @response_id = params[:response_id]
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
