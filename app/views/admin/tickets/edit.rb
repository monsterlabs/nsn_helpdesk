class Views::Admin::Tickets::Edit < Views::Layouts::Application
  def page_title
    "Edit Ticket"
  end
  
  def view_content
    rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
    form_for(@ticket, :url => { :action => "update"}) do |f|
       h2 do
         text 'Case details'
      end

      widget Views::Admin::Tickets::Form, :f => f
      
      rawtext f.submit 'Update', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)            
     end
  end
end
