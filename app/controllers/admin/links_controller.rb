class Admin::LinksController < Operator::TicketsController
  unloadable
  super_scaffold :class_name => Link, :name_space => "field_manager", :columns => {:sites => 'string', :frequency_tx => 'string', :frequency_rx => 'string', :current_status => 'string', :time_zone => 'select'}

  def new
    @record = Link.new
    @columns = {:sites => 'string', :frequency_tx => 'string', :frequency_rx => 'string', :current_status => 'string', :time_zone => 'select'}
    respond_to do |format|
      format.html { render 'super_scaffold/new' }
      format.js { render 'new_js' }
    end
  end

  def update
    @record = Link.find(params[:id])
    @record.ip_address = request.remote_ip    
    @record.modified_by_id = current_user.id
    respond_to do |format|    
      if @record.update_attributes(params[:link])
        format.html { redirect_to :action => :index }
      else
        format.html { render  'super_scaffold/edit' }
      end
    end   
  end

  def show
    @record = Link.find(params[:id])
    respond_to do |format|    
        format.html { render  'show' }
        format.js { render 'show_js' }
    end
  end
  
  def edit
    @record = Link.find(params[:id])
    @columns = {:sites => 'string', :frequency_tx => 'string', :frequency_rx => 'string', :current_status => 'string', :time_zone => 'select'}
    respond_to do |format|    
        format.html { render 'super_scaffold/edit' }
        format.js { render 'edit_js' }
    end
  end
  
  def index
    @collection = Link.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    render 'index'
  end

end
