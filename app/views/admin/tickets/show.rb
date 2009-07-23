class Views::Admin::Tickets::Show < Views::Layouts::Application
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
       rawtext link_to('Back', {:action => 'index'}, ui_style(:button))
     end
   end
end
