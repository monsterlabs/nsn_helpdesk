class Views::FieldManager::Tickets::ChangeAssignedStatus < Views::Layouts::Application

  def page_title
    "Solve Ticket"
  end

  def view_content
    rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
    form_for(@ticket, :url => {:action => "solve_ticket", :id => @ticket.id}) do |f|
      h2 do
        text 'Solve ticket'
      end
      div :class => 'solve_ticket_attributes' do
        span :class => 'status' do
          label b "Comments:"

          rawtext f.submit 'Solve ticket', ui_style(:button)
          link_to 'Cancel', {:action => :index},  ui_style(:button)      
        end    
      end
    end
  end
end
