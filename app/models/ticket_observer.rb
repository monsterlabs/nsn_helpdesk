class TicketObserver < ActiveRecord::Observer
  observe :ticket
  def after_create(ticket)
    MobileMessage.create(:ticket => ticket, :phone_number => ticket.emergency_phone_number)
  end
end
