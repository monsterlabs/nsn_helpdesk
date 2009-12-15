class TicketsController < ApplicationController
  skip_before_filter :filter_access_filter
  skip_before_filter :require_user
  
  list_for :ticket, :include => [:priority, :status, :region]
  multiple_auto_complete_for :person, [:lastname, :firstname]
  multiple_auto_complete_for :link, [:sites]
  
  def index
    @collection = Ticket.search_and_paginate(params[:filter], params[:page] || 1)
    respond_to do |format|
      format.html { render 'tickets/index' }
      format.js { render 'tickets/list_js'}
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
        format.js   { render 'tickets/create_js' }
      else
        format.html { render 'tickets/new' }
        format.js { render 'tickets/errors_js'}
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

  def mine
    params[:filter] ||= {}
    @collection = Ticket.search_and_paginate(params[:filter].merge!({:assigned_to_id_equals => current_user.id}), params[:page] || 1)
     respond_to do |format|
       format.html { render 'tickets/index' }
       format.js { render 'tickets/list_js'}
     end
  end

end
