class Operator::TicketsController < ApplicationController

  def index
    @collection = Ticket.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    respond_to do |format|
      format.html { render :action => 'index'}
    end    
  end

  def new
    @ticket = Ticket.new
    respond_to do |format|
      format.html { render :action => 'new'}
    end    
  end

  def create
    @ticket = Ticket.new(params[:ticket].merge(:opened_by_id => current_user.id))
    @ticket.due_date = @ticket.convert_to_date(params[:date])
    respond_to do |format|
      if @ticket.save
        Notifier.deliver_ticket_sent(@ticket)
        format.html { redirect_to :action => 'index' }
      else
        format.html { render :action => 'new'}
      end
    end        
  end
  
  def show
    @ticket = Ticket.find(params[:id])
    respond_to do |format|    
      format.html { render :action => 'show'}
    end    
  end

  def edit
    @ticket = Ticket.find(params[:id])    
    respond_to do |format|    
      format.html { render :action => 'edit'}
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.due_date = @ticket.convert_to_date(params[:date])
    respond_to do |format|    
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to :action => 'index' }
      else
        format.html { render :action => 'edit'}
      end
    end   
  end

end
