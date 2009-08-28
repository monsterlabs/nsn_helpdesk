class Views::Tickets::CurrentData < Erector::RailsWidget
  needs :ticket
  include ApplicationHelper
  
  def content
    tr :id=> 'ticket_title' do
      td {}
      td {label "Ticket Details"}
    end 
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Customer's name"
      end
      td :id => 'ticket_right_cell' do 
        rawtext  ticket.reported_by.person.fullname
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Customer's company"
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.reported_by.person.company.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Customer's phone"
      end
      td :id => 'ticket_right_cell' do 
        rawtext  show_value(ticket.reported_by.address, :business_phone)
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Customer's mobile phone"
      end
      td :id => 'ticket_right_cell' do 
        rawtext  show_value(ticket.reported_by.address, :mobile_phone)
      end
    end
    tr do
      td :id => 'ticket_left_cell' do 
        text "Customer's email"
      end
      td :id => 'ticket_right_cell' do 
        rawtext  ticket.reported_by.email
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Customer's zone time"
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.opened_at_local
      end
    end
    unless ticket.alternate_contact.nil?
      tr do 
        td :id => 'ticket_left_cell' do 
          text "Customer's contact name"
        end
        td :id => 'ticket_right_cell' do 
          rawtext  ticket.alternate_contact.person.fullname
        end
      end
      tr do 
        td :id => 'ticket_left_cell' do 
          text "Customer's contact e-mail"
        end
        td :id => 'ticket_right_cell' do 
          rawtext  ticket.alternate_contact.email
        end
      end
      tr do 
        td :id => 'ticket_left_cell' do 
          text "Customer's contact mobile phone"
        end
        td :id => 'ticket_right_cell' do 
          rawtext  show_value(ticket.alternate_contact.address, :mobile_phone)
        end
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Case ID"
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.case_id
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "NSN Engineer on duty"
      end
      td :id => 'ticket_right_cell' do 
        rawtext !ticket.assigned_to.nil? ? ticket.assigned_to.person.fullname : ticket.link.region.users.field_managers.collect {|fm| fm.person.fullname }.join(', ')
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "NSN Engineer ID number"
      end
      td :id => 'ticket_right_cell' do 
        rawtext !ticket.assigned_to.nil? ? ticket.assigned_to.id : ticket.link.region.users.field_managers.collect {|fm| fm.id }.join(', ')
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "NSN Engineer contact time"
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.created_at.to_s + ' America/Mexico_City'
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Call handle time'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.capture_time
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Network element (product)'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.product.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Link region'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.link.region.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Failure'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.failure.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Status'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.status.name
      end
    end

    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Priority'
      end
      td :id => 'ticket_right_cell' do 
        rawtext priority_label(ticket.reported_priority.name)
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Links'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.link.sites
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'More affected site'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.affected_sites
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Frequency TX'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.link.frequency_tx
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Frequency RX'
      end
      td :id => 'ticket_right_cell' do 
        text ticket.link.frequency_rx
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Configuration'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.link.configuration
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Alarm(s)'
      end
      td :id => 'ticket_right_cell' do 
        text show_value(ticket, :alarm)
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Special instruction(s)'
      end
      td :id => 'ticket_right_cell' do 
        text show_value(ticket, :special_instructions)
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Phone call attended by'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.attended_by.person.fullname
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Recommended priority'
      end
      td :id => 'ticket_right_cell' do 
        rawtext priority_label(ticket.priority.name)
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Opened by'
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.opened_by.person.nil? ? ticket.opened_by.email : ticket.opened_by.person.fullname 
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Opened Date '
      end
      td :id => 'ticket_right_cell' do 
        rawtext ticket.opened_at.to_s + ' America/Mexico_City'
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Additional notes'
      end
      td :id => 'ticket_right_cell' do 
        rawtext show_value(ticket, :notes)
      end
    end
  end
end
