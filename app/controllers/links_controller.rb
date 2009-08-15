class LinksController < ApplicationController
  unloadable
  def new
    @link = Link.new
    @region_id = params[:region_id]
    respond_to do |format|
      format.html { render 'links/new' }
      format.js { render 'links/new_js' }
    end
  end
  
  def create
    @link = Link.new(params[:link])
    respond_to do |format|
      if @link.save 
        format.html { redirect_to links_url }
        format.js { render 'links/show_js' }
      else
        format.html {render 'links/new'}
      end
    end
  end

  def update
    @link = Link.find(params[:id])
    @link.ip_address = request.remote_ip    
    @link.modified_by_id = current_user.id
    respond_to do |format|    
      if @link.update_attributes(params[:link])
        format.html { redirect_to links_url }
        format.js { render 'links/show_js' }
      else
        format.html { render  'links/edit' }
        format.js { }
      end
    end   
  end

  def show
    @link = Link.find(params[:id])
    respond_to do |format|    
        format.html { render  'links/show' }
        format.js { render 'links/show_js' }
    end
  end
  
  def edit
    @link = Link.find(params[:id])
    @region_id = params[:region_id]
    respond_to do |format|    
        format.html { render 'links/edit' }
        format.js { render 'links/edit_js' }
    end
  end
  
  def index
    @collection = Link.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    render 'links/index'
  end
  
  def filter
    @collection = Link.search_and_paginate(params[:filter], params[:page] || 1)
    respond_to do |format|
        format.js { render 'links/list_js'}
    end
  end
end
