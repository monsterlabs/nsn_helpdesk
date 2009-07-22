class Views::FieldManager::Tickets::Show < Views::Layouts::Application
  def page_title
     "Show Ticket"
   end

   def view_content
     table :id => "show" do

       tr do 
           td { b 'Key' }
           td { rawtext @ticket.case_id }
        end

       tr do 
         td { b 'Product' }
         td { rawtext @ticket.product.name }
       end

        tr do 
            td { b 'Reported by' }
            td { rawtext @ticket.reported_by.person.fullname }
        end

         tr do 
             td { b 'Link' }
             td { rawtext  @ticket.link.sites }
         end

         tr do 
             td { b 'Frequency TX' }
             td { rawtext @ticket.frequency_tx }
         end

         tr do 
             td { b 'Frequency RX' }
             td { rawtext @ticket.frequency_rx }
         end

         tr do 
             td { b 'Priority reported by user' }
             td { rawtext @ticket.reported_priority_id }
         end

         tr do 
             td { b 'Problem description' }
             td { rawtext @ticket.failure.title }
         end

         tr do 
             td { b 'Alarm description' }
             td { rawtext @ticket.alarm }
         end

         tr do 
             td { b 'Special instructions' }
             td { rawtext @ticket.special_instructions }
         end

         tr do 
             td { b 'Status' }
             td { rawtext @ticket.status.name }
         end

         tr do 
             td { b 'Attended by' }
             td { rawtext @ticket.attended_by.person.fullname }
         end

         tr do 
             td { b 'Priority suggested by Field Manager' }
             td { rawtext @ticket.priority.name }
         end

     end

     div do
       rawtext link_to('Modify', {:action => 'edit', :id => @ticket.id}, ui_style(:button))
       rawtext link_to('Cancel', {:action => 'index'}, ui_style(:button))
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
