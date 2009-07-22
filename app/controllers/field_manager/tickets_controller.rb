class FieldManager::TicketsController < Operator::TicketsController

  def change_status
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'change_status'}
    end    
  end
  
  def assign_ticket
    @collection = Ticket.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket].merge(:status_id => 2))
        format.html { render :action => 'index'}
      else
        format.html { render :action => 'change_status'}
      end
    end        
  end

  def solve_ticket
  end

  def close_ticket
  end

end
