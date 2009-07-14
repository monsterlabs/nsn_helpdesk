class Notifier < ActionMailer::Base

  def ticket_sent(ticket)
    @subject    = '[SOSBOX] Ticket has been sent'
    @recipients = 'fereyji@hotmail.com'
    @from       = 'noreply@sosbox.com'
    @sent_on    = Time.now
    @body       = { :ticket => ticket}
  end

end
