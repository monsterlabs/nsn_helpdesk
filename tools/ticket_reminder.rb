#!/usr/bin/env script/runner

# Listing tickets with *Open* status and *High* priority
Ticket.all(:conditions => { :status_id => 1, :priority_id => 1}).each do |ticket|
    puts ticket.id
    if ticket.opened_at + 2.hours > Time.now
      Notifier.deliver_reminder_notification(ticket)
    end
end
