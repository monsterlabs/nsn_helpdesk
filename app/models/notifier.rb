class Notifier < ActionMailer::Base

  def ticket_notifications(ticket)
    @subject    = 'Ticket has been sent'
    @recipients = 'fereyji@hotmail.com' # @ticket.reported_by.email
    @from       = 'noreply@sosbox.com'
    @sent_on    = Time.now
    @body       = { :ticket => ticket}

#    User.field_managers.each do |field_manager|
#      Notifier.deliver_fieldmanager_notification(ticket, field_manager.email)
#    end

  end

  def fieldmanager_notification(ticket, email)
    ticket.priority_id == 2021924194? (prefix='EME Case') : (prefix='Case')
    @subject    = prefix + ": - #{ticket.case_id} - #{ticket.reported_by.person.company.name}. - Status: #{ticket.status.name.upcase}"
    @recipients = 'fereyji@hotmail.com' #email
    @from       = 'noreply@notification.com'
    @sent_on    = Time.now
    @body       = { :ticket => ticket}
  end

  def random_password(user, password)
    @subject    = '[SOSBOX] Your password has been reset'
    @recipients = user.email
    @from       = 'noreply@sosbox.com'
    @sent_on    = Time.now
    @body       = { :user => user, :password => password}
  end

end
