class Corporate::TicketsController < TicketsController
  def index
    @collection = Ticket.search_and_paginate({:region_id_equals => current_user.person.region_id}, params[:page] || 1)
    respond_to do |format|
      format.html { render 'tickets/index' }
    end        
  end

  def filter
    @collection = Ticket.search_and_paginate(params[:filter].merge({:region_id_equals => current_user.person.region_id}), params[:page] || 1)

    respond_to do |format|
      format.js { render 'tickets/list_js'}
    end
  end
end
