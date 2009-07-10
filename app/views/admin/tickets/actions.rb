class Views::Admin::Tickets::Actions < Erector::RailsWidget
  needs :ticket_id
  def content
    link_to 'Edit', :action => 'edit', :id => ticket_id
    text ' | '
    link_to 'Show', :action => 'show', :id => ticket_id
    text ' | '    
    link_to 'Destroy', {:action => :destroy, :id => ticket_id}, :method => :delete, :confirm => 'Do you want to delete this record ?'
  end
end
