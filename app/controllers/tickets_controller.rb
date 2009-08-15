class TicketsController < ApplicationController
  
  list_for :ticket, :include => [:priority, :status, :region]
  multiple_auto_complete_for :person, [:lastname, :firstname]
  multiple_auto_complete_for :link, [:sites]
  
  def index
    @collection = Ticket.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    respond_to do |format|
      format.html { render 'tickets/index' }
    end    
  end
  
  def new
    @ticket = Ticket.new(:opened_at => Time.now)
    respond_to do |format|
      format.html { render 'tickets/new' }
    end    
  end
  
  def create
    @ticket = Ticket.new(params[:ticket].merge(:ip_address => request.remote_ip, :opened_by_id => current_user.id))
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to :action => :index }
      else
        format.html { render 'tickets/new' }
      end
    end        
  end
  
  def show
    @ticket = Ticket.find(params[:id])
    respond_to do |format|    
      format.html { render 'tickets/show' }
    end    
  end
  
  def details
    respond_to do |format|
      format.js { render 'tickets/details_js' }
    end
  end
  
  def filter
    @collection = Ticket.search_and_paginate(params[:filter], params[:page] || 1)
    
    respond_to do |format|
      format.js { render 'tickets/list_js'}
    end
  end

end
