class Views::Tickets::Versions < Erector::RailsWidget
  needs :ticket

  def content
    tr :id => "ticket_title" do 
      td {}
      td {label "Ticket Version(s)"}
    end
    tr do 
      td :id => "ticket_left_cell" do 
        label h3 "This ticket has #{@ticket.versions.size} version(s)"
      end
      td :id => "ticket_right_cell" do 
      end
    end   
    
    @ticket.versions.reverse.each do |version| 
      tr do 
        td :id => "ticket_left_cell" do 
        end
        td :id => "ticket_right_cell" do 
          rawtext b "Version #{version.index + 1}"
        end
      end   
      tr do 
        td :id => "ticket_left_cell" do 
          text "Created by"
        end
        td :id => "ticket_right_cell" do 
          rawtext who_has_changed_it(version.whodunnit)
        end
      end    
      tr do 
        td :id => "ticket_left_cell" do 
          text "Created at"
        end
        td :id => "ticket_right_cell" do 
          rawtext @ticket.created_at
        end
      end  

      unless version.object.nil?
        tr do 
          td :id => "ticket_left_cell" do 
            text "IP Address"
          end
          td :id => "ticket_right_cell" do 
            rawtext version.reify.ip_address.slice(7..22)
          end
        end            
        tr do 
          td :id => "ticket_left_cell" do 
            text "Status"
          end
          td :id => "ticket_right_cell" do 
            rawtext version.reify.status.name
          end
        end            
        tr do 
          td :id => "ticket_left_cell" do 
            text "Event"
          end
          td :id => "ticket_right_cell" do 
            rawtext version.event
          end
        end            
        tr do 
          td :id => "ticket_left_cell" do 
            text 'Customer name'
          end
          td :id => "ticket_right_cell" do 
            rawtext  version.reify.reported_by.person.fullname
          end
        end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Custmomer's company"
      end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.reported_by.person.company.name unless version.reify.reported_by.person.company.nil?
          end
        end
        tr do 
          td :id => "ticket_left_cell" do 
            text "Customer's contact phone"
          end
          td :id => "ticket_right_cell" do 
            rawtext  version.reify.reported_by.address.business_phone
          end
        end
        tr do 
          td :id => "ticket_left_cell" do 
            text "Customer's mobile phone"
          end
          td :id => "ticket_right_cell" do 
            rawtext  version.reify.reported_by.address.mobile_phone
          end
        end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Customer's contact time"
      end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.opened_at_local
          end
        end
   tr do
      td :id => 'ticket_left_cell' do 
        text "Customer's email"
      end
      td :id => 'ticket_right_cell' do 
            rawtext  version.reify.reported_by.email
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "Case ID"
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.case_id
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "NSN Engineer on duty"
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.assigned_to.person.fullname unless  version.reify.assigned_to.nil?
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "NSN Engineer ID number"
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.attended_by.id
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text "NSN Engineer contact time"
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.created_at.to_s + ' America/Mexico_City'
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Call handle time'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.capture_time
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Network element (product)'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.product.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Name of site / hostname (region)'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.link.region.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Failure'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.failure.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Status'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.status.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Priority'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.link.configuration + ' ' + version.reify.reported_priority.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Links'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.link.sites
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'More affected site'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.affected_sites
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Frequency TX'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.link.frequency_tx
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Frequency RX'
      end
      td :id => 'ticket_right_cell' do 
        text version.reify.link.frequency_rx
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Alarm(s)'
      end
      td :id => 'ticket_right_cell' do 
        text version.reify.alarm
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Special instruction(s)'
      end
      td :id => 'ticket_right_cell' do 
        text version.reify.special_instructions
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Phone call attended by'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.attended_by.person.fullname
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Recommended priority'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.priority.name
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Opened Date '
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.opened_at
      end
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        text 'Additional notes'
      end
      td :id => 'ticket_right_cell' do 
        rawtext version.reify.notes
      end
    end
      end
    end
  end
end




