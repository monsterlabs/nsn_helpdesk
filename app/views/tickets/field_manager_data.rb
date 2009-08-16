class Views::Tickets::FieldManagerData < Erector::RailsWidget
  needs :ticket

  def content
    tr do 
      td :id => 'ticket_left_cell' do 
        text (@ticket.status.id == 2 ? 'Assigned to' : "#{@ticket.status.name} by: ")
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.assigned_to.person.fullname
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Due Date'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.due_date
      end
    end

   if @ticket.status.name == 'Closed'
      tr do 
        td :id => 'ticket_left_cell' do 
          text 'Ticket Type'
        end
        td :id => 'ticket_right_cell' do 
          rawtext @ticket.ticket_type.name
        end
      end
    end
  end
end
