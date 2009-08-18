class TicketObserver < ActiveRecord::Observer
  observe :ticket
  def after_create(ticket)
    if ticket.reported_priority.name == 'High' and ENV['RAILS_ENV'] == 'production'
      User.emergencies.each do |emergency_user|
        emergency_user.mobile_phones.each do |phone_number|
          #MobileMessage.create(:messageable => ticket, :phone_number => phone_number) 
        end
      end
    end
    Notifier.queue(:ticket_notifications, ticket)
  end
end
