class Notifier < ActionMailer::Base
  helper :application
  def ticket_notification(ticket)
    setup
    @subject    = "#{@subject_prefix} Ticket has been sent"
    @recipients = ticket.opened_by.email
    attachment :content_type => "text/html", :disposition => :inline, :body => render_message('ticket_notification', :ticket => ticket)
  end

  def fieldmanager_notification(ticket, email)
    setup
    prefix = (ticket.reported_priority.name == 'High' ? 'EME Case' : 'Case')
    @subject    = @subject_prefix + prefix + ": - #{ticket.case_id} - #{ticket.reported_by.person.company.name}. - Status: #{ticket.status.name.upcase}"
    @recipients = email
    attachment :content_type => "text/html", :disposition => :inline, :body => render_message('fieldmanager_notification', :ticket => ticket)
  end

  def random_password(user, password)
    setup
    @subject    = "#{@subject_prefix} Your password has been reset"
    @recipients = user.email
    @content_type = "text/html" 
    @body       = { :user => user, :password => password}
  end

  def link_notifications(link)
    setup
    @subject    = "#{@subject_prefix} Link updated"
    @recipients = link.region.users.field_managers.collect { |fm| fm.email }
    attachment :content_type => "text/html", :disposition => :inline, :body => render_message('link_notifications',:link => link)
  end

  def reminder_notification(ticket)
    setup
    @subject    = "#{@subject_prefix} Reminder"
    @recipients = User.field_managers.collect { |fm| fm.email }
    attachment :content_type => "text/html", :disposition => :inline, :body => render_message('reminder_notification', :ticket => ticket)
  end

  def ticket_status_changed_notification(ticket)
    setup
    @subject    = "#{@subject_prefix} Ticket #{ticket.status.name.downcase}"
    @recipients = User.field_managers.collect { |user| user.email }
    attachment :content_type => "text/html", :disposition => :inline, :body => render_message('ticket_closed_notification', :ticket => ticket)
  end

  def setup
    @from       = 'callcenter@lattice.com.mx'
    @sent_on    = Time.now
    @content_type = "multipart/related"
    @subject_prefix = '[NSNCallCenter] '
  end
end
