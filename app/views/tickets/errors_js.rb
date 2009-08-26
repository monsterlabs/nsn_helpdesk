class Views::Tickets::ErrorsJs < Views::Layouts::ApplicationJs
  def js_content
    errors = error_messages_for('ticket', :class => 'ui-state-error ui-corner-all').gsub(/\'/,'`')
    rawtext "$('#ticket_errors').html('#{errors}');"
  end
end