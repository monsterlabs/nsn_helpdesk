class Operator::TicketsController < ApplicationController

  def index
    @collection = Ticket.all
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
    @ticket = Ticket.new(params[:ticket])
    respond_to do |format|
      if @ticket.save
        format.html { render :action => 'index'}
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
    respond_to do |format|    
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to :action => 'index'}
      else
        format.html { render :action => 'edit'}
      end
    end   
  end

end
