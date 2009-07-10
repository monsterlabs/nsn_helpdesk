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

end
