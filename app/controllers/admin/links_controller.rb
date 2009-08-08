class Admin::LinksController < Operator::TicketsController
  unloadable

  def new
    @link = Link.new
    respond_to do |format|
      format.html { render 'new' }
      format.js { render 'new_js' }
    end
  end
  
  def create
    @link = Link.new(params[:link])
    if @link.save 
      redirect_to :controller => "admin/links"
    else
      render 'new'
    end
  end

  def update
    @link = Link.find(params[:id])
    @link.ip_address = request.remote_ip    
    @link.modified_by_id = current_user.id
    respond_to do |format|    
      if @link.update_attributes(params[:link])
        format.html { redirect_to :action => :index }
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
    respond_to do |format|    
        format.html { render 'edit' }
        format.js { render 'edit_js' }
    end
  end
  
  def index
    @collection = Link.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    render 'index'
  end
  
  def destroy
    @link = Link.find(params[:id])
    if @link.destroy
      redirect_to :controller => 'admin/links'
    end
  end

end
