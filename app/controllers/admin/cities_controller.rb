class Admin::CitiesController < ApplicationController
  super_scaffold :class_name => Failure, :name_space => "admin"
  
  def new
    @record = City.new
    respond_to do |format|
      format.js { render 'new_js' }
    end
  end
  
  def create
    @record = City.new(params[:city])
    if @record.save 
      respond_to do |format|
        format.html { redirect_to :controller => City.controller_url("admin") }
        format.js { render 'create_js.rb' }
       end
    else
      render 'super_scaffold/new'
    end
  end
end