class FieldManager::LinksController < Operator::TicketsController
#  filter_access_to :all
  super_scaffold :class_name => Link, :name_space => "field_manager", :columns => {:sites => 'string', :frequency_tx => 'string', :frequency_rx => 'string', :current_status => 'string'}


  def update
    @record = Link.find(params[:id])
    @record.user_id = current_user.id
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
    end
  end
end
