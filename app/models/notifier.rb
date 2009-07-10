class Notifier < ActionMailer::Base
  

  def ticket_sent(sent_at = Time.now)
    subject    '[SOSBOX] Ticket has been sended'
    recipients 'fereyji@hotmail.com'
    from       'no-reply@sosbox.com'
    sent_on    Date.today
    body       :greeting => 'Hi,'
  end

end
