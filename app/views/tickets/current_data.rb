class Views::Tickets::CurrentData < Erector::RailsWidget
  needs :ticket
  
  def content
    tr :id=> 'ticket_title' do
      td {}
      td {label "Ticket Currrent Data"}
    end 
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Case ID"
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.case_id
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Region'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.link.region.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Customer name'
      end
      td :id => 'ticket_right_cell' do 
        rawtext  @ticket.reported_by.person.fullname
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Company'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.reported_by.person.company.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Link'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.link.sites
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Affected Site(s)'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.affected_site
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Priority'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.priority.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Failure'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.failure.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Alarm(s)'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.alarm
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Attended by'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.attended_by.person.fullname
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Opened Date '
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.opened_at
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Call handle time'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.capture_time
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Current Status'
      end
      td :id => 'ticket_right_cell' do 
        rawtext @ticket.status.name
      end
    end
  end

end
