class FieldManager::TicketsController < TicketsController
  def edit
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.html { render 'field_manager/tickets/edit' }
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to :action => :index }
      else
        format.html { render 'field_manager/tickets/edit'}
      end
    end
  end
end
