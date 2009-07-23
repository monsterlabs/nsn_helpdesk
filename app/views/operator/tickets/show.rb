class Views::Operator::Tickets::Show < Views::Layouts::Application
  def page_title
     "Show Ticket"
   end

   def view_content
     table :id => "show" do

        tr do 
            td { b 'Case ID' }
            td { rawtext @ticket.case_id }
        end

         tr do 
           td { b 'Region' }
           td { rawtext @ticket.link.region.name }
         end

        tr do 
            td { b 'Link' }
            td { rawtext @ticket.link.sites }
        end

        tr do 
            td { b 'Affected Site' }
            td { rawtext @ticket.affected_site }
        end

        tr do 
            td { b 'Frequency TX' }
            td {
                rawtext @ticket.frequency_tx 
                label " MHz"
               }
        end

        tr do 
            td { b 'Frequency RX' }
            td {
                rawtext @ticket.frequency_rx 
                label " MHz"
               }
        end

         tr do 
           td { b 'Priority' }
           td { rawtext @ticket.priority.name }
         end

        tr do 
            td { b 'Subject' }
            td { rawtext @ticket.failure.name }
        end

        tr do 
            td { b 'Alarms' }
            td { rawtext @ticket.alarm }
        end

        tr do 
            td { b 'Customer' }
            td { rawtext @ticket.reported_by.person.company.name }
        end

        tr do 
            td { b 'Customer name' }
            td { rawtext @ticket.reported_by.person.fullname }
        end

        tr do 
            td { b 'Attended by' }
            td { rawtext @ticket.attended_by.person.fullname}
        end

        tr do 
            td { b 'Opened Date' }
            td { rawtext @ticket.opened_at }
        end

        tr do 
            td { b 'Due Date' }
            td { rawtext @ticket.due_date }
        end

        tr do 
            td { b 'Status' }
            td { rawtext @ticket.status.name }
        end


         tr do 
             td { b 'Calls handle time' }
             td { rawtext @ticket.capture_time }
         end

     end

     div do
       rawtext link_to('Modify', {:action => 'edit', :id => @ticket.id}, ui_style(:button))
       rawtext link_to 'Back', {:action => 'index'}, ui_style(:button)    
     end

       table :id => "header" do
         tr do 
           td { label h3 "This ticket has #{@ticket.versions.size} version(s)."}
         end
       end
       
       @ticket.versions.reverse.each do |version|
         table :id => "versions" do
           tr do
             td {label "Version #{version.index + 1}:"}
           end
            tr do
              td {label "Created by:"}
              td {rawtext Person.find_by_user_id(version.whodunnit).fullname unless Person.find_by_user_id(version.whodunnit).nil?}
            end
         unless version.object.nil?
            tr do
              td {label "IP Address:"}
              td {rawtext version.object.split(/\n/).map {|part| part.split[1] if part.match(/ip_address/)}}
            end
            tr do
              td {label "Status:"}
              td {rawtext version.object.split(/\n/).map {|part| Status.find(part.split[1]).name if part.match(/status/)}}
            end
         end
            tr do
              td {label "Event"}
              td {rawtext version.event}
            end
            tr do
              td {label "Created at"}
              td {rawtext version.created_at :short}
            end
       end
     end

   end
end
