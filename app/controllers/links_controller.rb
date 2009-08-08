class LinksController < ApplicationController
  unloadable

  def new
    @link = Link.new
    @region_id = params[:region_id]
    respond_to do |format|
      format.html { render 'new' }
      format.js { render 'new_js' }
    end
  end
  
  def create
    @link = Link.new(params[:link])
    respond_to do |format|
      if @link.save 
        format.html { redirect_to links_url }
        format.js { render 'show_js' }
      else
        format.html {render 'new'}
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
        format.js { render 'show_js' }
      else
        format.html { render  'edit' }
        format.js { }
      end
    end   
  end

  def show
    @link = Link.find(params[:id])
    respond_to do |format|    
        format.html { render  'show' }
        format.js { render 'show_js' }
    end
  end
  
  def edit
    @link = Link.find(params[:id])
    @region_id = params[:region_id]
    respond_to do |format|    
        format.html { render 'edit' }
        format.js { render 'edit_js' }
    end
  end
  
  def index
    @collection = Link.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    render 'index'
  end
end
