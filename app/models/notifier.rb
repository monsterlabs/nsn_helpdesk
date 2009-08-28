class Notifier < ActionMailer::Base
  helper :application
  def ticket_notifications(ticket)
    @subject    = '[NSNCallCenter] Ticket has been sent'
    @recipients = ticket.opened_by.email
    @from       = 'callcenter@lattice.com.mx'
    @sent_on    = Time.now
    @body       = { :ticket => ticket}
    @content_type = "text/html"

    Notifier.queue(:fieldmanager_notification, ticket, ticket.attended_by.email)
    ticket.link.region.users.field_managers.each do |field_manager|
      Notifier.queue(:fieldmanager_notification, ticket, field_manager.email) if field_manager.email != ticket.attended_by.email
    end
  end

  def fieldmanager_notification(ticket, email)
    ticket.reported_priority.name == 'High' ? (prefix='EME Case') : (prefix='Case')
    @subject    = prefix + ": - #{ticket.case_id} - #{ticket.reported_by.person.company.name}. - Status: #{ticket.status.name.upcase}"
    @recipients = email
    @from       = 'callcenter@lattice.com.mx'
    @sent_on    = Time.now
    @body       = { :ticket => ticket}
    @content_type = "text/html"
  end

  def random_password(user, password)
    @subject    = '[NSNCallCenter] Your password has been reset'
    @recipients = user.email
    @from       = 'noreply@nsnmwcaretelcel.com'
    @sent_on    = Time.now
    @body       = { :user => user, :password => password}
    @content_type = "text/html"
  end

  def link_notifications(link)
    @subject    = '[NSNCallCenter] Link updated'
    @recipients = link.region.users.field_managers.collect { |fm| fm.email }
    @from       = 'noreply@nsnmwcaretelcel.com'
    @sent_on    = Time.now
    @body       = {:link => link }
    @content_type = "text/html"
  end

  def reminder_notification(ticket)
    @subject    = '[NSNCallCenter] Reminder'
    @recipients = User.field_managers.collect { |fm| fm.email }
    @from       = 'noreply@nsnmwcaretelcel.com'
    @sent_on    = Time.now
    @body       = {:ticket => ticket }    
    @content_type = "text/html"
  end

  def ticket_closed_notification(ticket)
    @subject    = '[NSNCallCenter] Ticket closed'
    @recipients = User.group_and_field_managers_collection.collect {|user| user.email}
    @from       = 'noreply@nsnmwcaretelcel.com'
    @sent_on    = Time.now
    @body       = {:ticket => ticket }    
    @content_type = "text/html"
  end
  
end
