class TicketObserver < ActiveRecord::Observer
  observe :ticket
  def after_create(ticket)
    MobileMessage.create(:messageable => ticket, :phone_number => ticket.emergency_phone_number)
    Notifier.queue(:ticket_notifications, ticket)
  end
end
