class Notifier < ActionMailer::Base

  def ticket_notifications(ticket)
    @subject    = '[NSNCallCenter] Ticket has been sent'
    @recipients = 'fereyji@gmail.com' # @ticket.reported_by.email
    @from       = 'noreply@nokia.call.center.com'
    @sent_on    = Time.now
    @body       = { :ticket => ticket}

    managers = User.field_managers
    managers.shift
    managers.each do |field_manager|
      Notifier.deliver_fieldmanager_notification(ticket, field_manager.email)
    end

  end

  def fieldmanager_notification(ticket, email)
    ticket.reported_priority.name == 'High' ? (prefix='EME Case') : (prefix='Case')
    @subject    = prefix + ": - #{ticket.case_id} - #{ticket.reported_by.person.company.name}. - Status: #{ticket.status.name.upcase}"
    @recipients = 'fereyji@gmail.com' #email
    @from       = 'noreply@nokia.call.center.com'
    @sent_on    = Time.now
    @body       = { :ticket => ticket}
  end

  def random_password(user, password)
    @subject    = '[NSNCallCenter] Your password has been reset'
    @recipients = user.email
    @from       = 'noreply@nokia.call.center.com'
    @sent_on    = Time.now
    @body       = { :user => user, :password => password}
  end

  def link_notifications(link)
    @subject    = '[NSNCallCenter] Link updated'
    @recipients = 'fereyji@gmail.com' #field_managers_recipients
    @from       = 'noreply@nokia.call.center.com'
    @sent_on    = Time.now
    @body       = {:link => link }
  end

  def reminder_notification(ticket)
    @subject    = '[NSNCallCenter] Reminder'
    @recipients = 'fereyji@gmail.com' #field_managers_recipients
    @from       = 'noreply@nokia.call.center.com'
    @sent_on    = Time.now
    @body       = {:ticket => ticket }    
  end

  def field_managers_recipients
    manager = Array.new
    User.field_managers_collection.each do |field_manager|
      managers << field_manager.email
    end
  end

end
