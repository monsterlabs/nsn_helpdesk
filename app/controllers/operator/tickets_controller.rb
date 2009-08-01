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
        format.html { redirect_to :action => :index }
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
        format.html { redirect_to :action => :index }
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

  def search_by_case_id
    @ticket = Ticket.find_by_case_id(params[:q][:case_id])
    respond_to do |format|    
      if @ticket.nil?
        format.html { redirect_to :action => :index }
      else
        format.html { render 'show' }
      end
    end    
  end
  
  def filter
    @collection = Ticket
    if !(value = params[:filter][:case_id]).blank?
      @collection = @collection.case_id_like(value)
    end
    if !(value = params[:filter][:status_id]).blank?
      @collection = @collection.status_id_equals(value)
    end
    if !(value = params[:filter][:region_id]).blank?
      @collection = @collection.region_id_equals(value)
    end
    if !(value = params[:filter][:affected_site]).blank?
      @collection = @collection.affected_site_like(value)
    end
    if !(value = params[:filter][:priority_id]).blank?
      @collection = @collection.priority_id_equals(value)
    end
    
    @collection = @collection.paginate :page => 1, :per_page => 10
    
    respond_to do |format|
      format.js { render 'list_js'}
    end
  end
  
end
