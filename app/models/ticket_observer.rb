class TicketObserver < ActiveRecord::Observer
  observe :ticket
  def after_create(ticket)
    if ticket.reported_priority.name == 'High' and ENV['RAILS_ENV'] == 'production'
      MobileMessage.create(:messageable => ticket, :phone_number => ticket.emergency_phone_number) 
    end
    Notifier.queue(:ticket_notifications, ticket)
  end
end
