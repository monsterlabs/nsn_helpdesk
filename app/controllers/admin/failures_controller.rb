class Admin::FailuresController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => Failure, :name_space => "admin"
  
  def create
    @record = Failure.new(params[:failure])
    if @record.save 
      respond_to do |format|
        format.html { redirect_to :controller => Failure.controller_url("admin") }
        format.js { render 'create_js.rb' }
       end
    else
      render 'super_scaffold/new'
    end
  end
end