class Views::FieldManager::Tickets::Actions < Erector::RailsWidget
  needs :ticket_id
  def content
    link_to 'Edit', :action => 'edit', :id => ticket_id
    text ' | '
    link_to 'Show', :action => 'show', :id => ticket_id
  end
end
