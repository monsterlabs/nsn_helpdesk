class Notifier < ActionMailer::Base
  helper :application
  def ticket_notifications(ticket)
    setup
    @subject    = "#{@subject_prefix} Ticket has been sent"
    @recipients = ticket.opened_by.email
    @body       = { :ticket => ticket}
    Notifier.queue(:fieldmanager_notification, ticket, ticket.attended_by.email)
    ticket.link.region.users.field_managers.each do |field_manager|
      Notifier.queue(:fieldmanager_notification, ticket, field_manager.email) if field_manager.email != ticket.attended_by.email
    end
  end

  def fieldmanager_notification(ticket, email)
    setup
    prefix = (ticket.reported_priority.name == 'High' ? 'EME Case' : 'Case')
    @subject    = @subject_prefix + prefix + ": - #{ticket.case_id} - #{ticket.reported_by.person.company.name}. - Status: #{ticket.status.name.upcase}"
    @recipients = email
    @body       = { :ticket => ticket}
  end

  def random_password(user, password)
    setup
    @subject    = "#{@subject_prefix} Your password has been reset"
    @recipients = user.email
    @body       = { :user => user, :password => password}
  end

  def link_notifications(link)
    setup
    @subject    = "#{@subject_prefix} Link updated"
    @recipients = link.region.users.field_managers.collect { |fm| fm.email }
    @body       = { :link => link }
  end

  def reminder_notification(ticket)
    setup
    @subject    = "#{@subject_prefix} Reminder"
    @recipients = User.field_managers.collect { |fm| fm.email }
    @body       = { :ticket => ticket }    
  end

  def ticket_closed_notification(ticket)
    setup
    @subject    = "#{@subject_prefix} Ticket closed"
    @recipients = User.field_managers.collect { |user| user.email }
    @body       = { :ticket => ticket }    
  end

  def setup
    @from       = 'callcenter@lattice.com.mx'
    @sent_on    = Time.now
    @content_type = "text/html"
    @subject_prefix = '[NSNCallCenter-TEST] '
  end
end
