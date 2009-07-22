class FieldManager::TicketsController < Operator::TicketsController

  def change_status
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.html { render :action => "change_#{@ticket.status.name.downcase}_status", :id => @ticket.id}
    end    
  end
  
  def assign_ticket
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket].merge(:status_id => 2))
        @collection = Ticket.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
        format.html { render :action => 'index'}
      else
        format.html { render :action => 'change_open_status'}
      end
    end        
  end

  def solve_ticket
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket].merge(:status_id => 3))
        format.html { render :action => 'index'}
      else
        format.html { render :action => 'change_solve_status'}
      end
    end        
  end

  def close_ticket
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket].merge(:status_id => 4))
        format.html { render :action => 'index'}
      else
        format.html { render :action => 'change_close_status'}
      end
    end        
  end        


end
