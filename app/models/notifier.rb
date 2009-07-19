class Notifier < ActionMailer::Base

  def ticket_notifications(ticket)
    @subject    = '[SOSBOX] Ticket has been sent'
    @recipients = 'fereyji@hotmail.com' # @ticket.reported_by.email
    @from       = 'noreply@sosbox.com'
    @sent_on    = Time.now
    @body       = { :ticket => ticket}
    Notifier.deliver_fieldmanager_notification(ticket)
  end

  def fieldmanager_notification(ticket)
    @subject    = '[SOSBOX] Ticket has been attended'
    @recipients = 'fereyji@hotmail.com' # @ticket.attended_by.email
    @from       = 'noreply@sosbox.com'
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
