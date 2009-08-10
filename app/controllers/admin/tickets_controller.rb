class Admin::TicketsController < FieldManager::TicketsController
  
  def destroy
     @ticket = Ticket.find(params[:id])
     @ticket.destroy
     respond_to do |format|
       format.html { redirect_to :action => 'index' }
      end    
  end
  
end