class Operator::TicketsController < ApplicationController
  list_for :ticket, :include => [:priority, :status, :region]
  multiple_auto_complete_for :person, [:lastname, :firstname]
  multiple_auto_complete_for :link, [:sites]
  
  def index
    @collection = Ticket.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    respond_to do |format|
      format.html { render 'index' }
    end    
  end
  
  def new
    @ticket = Ticket.new(:opened_at => Time.now)
    respond_to do |format|
      format.html { render 'new' }
    end    
  end

  def create
    @ticket = Ticket.new(params[:ticket].merge(:ip_address => request.remote_ip, :opened_by_id => current_user.id))
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to operator_tickets_url }
      else
        format.html { render 'new' }
      end
    end        
  end
  
  def show
    @ticket = Ticket.find(params[:id])
    respond_to do |format|    
      format.html { render 'show' }
    end    
  end

  def edit
    @ticket = Ticket.find(params[:id])    
    respond_to do |format|    
      format.html { render 'edit' }
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    respond_to do |format|    
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to operator_tickets_url }
      else
        format.html { render  'edit'}
      end
    end   
  end
  
  def details
    respond_to do |format|
      format.js { render 'details_js' }
    end
  end
end
