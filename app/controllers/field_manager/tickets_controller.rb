class FieldManager::TicketsController < TicketsController
  
  def edit
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.html { render 'field_manager/tickets/edit' }
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.ip_address = request.remote_ip    
    @ticket.modified_by_id = current_user.id
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to :action => :index }
        format.js   { render 'field_manager/tickets/update_js' }
      else
        format.html { render 'field_manager/tickets/edit' }
        format.js { render 'field_manager/tickets/errors_js' }
        
      end
    end
  end
  
  def edit_change_status
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.js { render 'field_manager/tickets/edit_change_status_js' }
    end
  end
  
  def change_status
    @ticket = Ticket.find(params[:id])
    a = params[:ticket]
    a[:accepts_closing_id] = a[:reported_by_id]
    a.delete :reported_by_id
    respond_to do |format|
      if @ticket.update_attributes(a)
        format.js { render 'field_manager/tickets/change_status_js' }
      else
        format.js { render 'tickets/errors_js', :status => 500 }
      end
    end
  end 
  
end
