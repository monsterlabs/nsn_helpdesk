class TicketObserver < ActiveRecord::Observer
  observe :ticket
  def after_create(ticket)
    if ticket.reported_priority.name == 'High'
       User.emergencies.each do |emergency_user|
         emergency_user.mobile_phones.each do |phone_number|
           MobileMessage.create(:messageable => ticket, :phone_number => phone_number) 
         end
       end
     else
       ticket.link.region.users.field_managers.each do |field_manager|
         field_manager.mobile_phones.each do |phone_number|
           MobileMessage.create(:messageable => ticket, :phone_number => phone_number) 
         ends
       end
     end
    Notifier.queue(:ticket_notifications, ticket)
  end

  def after_update(ticket)
    Notifier.queue(:ticket_closed_notification, ticket) if ticket.status.name == 'Closed'
  end
end
