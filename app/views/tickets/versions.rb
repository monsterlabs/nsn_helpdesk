class Views::Tickets::Versions < Erector::RailsWidget
  needs :ticket
  def content
    tr :id => 'ticket_title' do 
      td {}
      td {label "Ticket Version(s)"}
    end
    tr do 
      td :id => 'ticket_left_cell' do 
        label h3 "This ticket has #{@ticket.versions.size} version(s)"
      end
      td :id => 'ticket_right_cell' do 
      end
    end   
    @ticket.versions.reverse.each do |version| 
      tr do 
        td :id => 'ticket_left_cell' do 
        end
        td :id => 'ticket_right_cell' do 
          rawtext b "Version #{version.index + 1}"
        end
      end   
      tr do 
        td :id => 'ticket_left_cell' do 
          text "Created by"
        end
        td :id => 'ticket_right_cell' do 
          rawtext Person.find_by_modified_by_id(version.whodunnit).fullname unless Person.find_by_modified_by_id(version.whodunnit).nil?
        end
      end    
      tr do 
        td :id => 'ticket_left_cell' do 
          text "Created at"
        end
        td :id => 'ticket_right_cell' do 
          rawtext @ticket.created_at
        end
      end  
      unless version.object.nil?
        tr do 
          td :id => 'ticket_left_cell' do 
            text "IP Address"
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.ip_address.slice(7..22)
          end
        end            
        tr do 
          td :id => 'ticket_left_cell' do 
            text "Status"
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.status.name
          end
        end            
        tr do 
          td :id => 'ticket_left_cell' do 
            text "Event"
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.event
          end
        end            
        
        
        tr do 
          td :id => 'ticket_left_cell' do 
            text 'Region'
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.link.region.name
          end
        end
        tr do 
          td :id => 'ticket_left_cell' do 
            text 'Customer name'
          end
          td :id => 'ticket_right_cell' do 
            rawtext  version.reify.reported_by.person.fullname
          end
        end
        tr do 
          td :id => 'ticket_left_cell' do 
            text 'Company'
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.reported_by.person.company.name
          end
        end
        tr do 
          td :id => 'ticket_left_cell' do 
            text 'Link'
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.link.sites
          end
        end
        tr do 
          td :id => 'ticket_left_cell' do 
            text 'Affected Site(s)'
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.affected_site
          end
        end
        tr do 
          td :id => 'ticket_left_cell' do 
            text 'Priority'
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.priority.name
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
            text 'Alarm(s)'
          end
          td :id => 'ticket_right_cell' do 
            rawtext version.reify.alarm
          end
        end
      end
    end
  end
end




