class FieldManager::TicketsController < Operator::TicketsController

  def show_field_managers
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'show_field_managers'}
    end    
  end
  
  def assign_field_manager
    @collection = Ticket.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      if @ticket.update_attribute(:assigned_to_id, params[:ticket]['assigned_to_id'])
        format.html { render :action => 'index'}
      else
        format.html { render :action => 'show_field_managers'}
      end
    end        
  end

end
