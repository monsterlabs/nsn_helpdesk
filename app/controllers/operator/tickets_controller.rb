class Operator::TicketsController < ApplicationController

  def index
    @tickets = Ticket.all
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
    respond_to do |format|
      format.html { render :action => 'index'}
    end        
  end

end
