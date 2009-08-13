class Views::Tickets::Show < Views::Layouts::Application
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
             td { b 'Customer name' }
             td { rawtext @ticket.reported_by.person.fullname }
         end

         tr do 
             td { b 'Company' }
             td { rawtext @ticket.reported_by.person.company.name }
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
           td { b 'Priority' }
           td { rawtext @ticket.priority.name }
         end

        tr do 
            td { b 'Failure' }
            td { rawtext @ticket.failure.name }
        end

        tr do 
            td { b 'Alarms' }
            td { rawtext @ticket.alarm }
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
            td { b 'Calls handle time' }
            td { rawtext @ticket.capture_time }
        end
      
        tr do 
            td { b 'Current Status' }
            td { rawtext @ticket.status.name }
        end
        
        unless @ticket.assigned_to.nil?
          tr do 
            mylabel = (@ticket.status.id == 2 ? 'Assigned to: ' : "#{@ticket.status.name} by: ")
            b mylabel
            td { b mylabel }
            td { rawtext @ticket.assigned_to.person.fullname }
          end

          tr do 
            td { b 'Due Date' }
            td { rawtext @ticket.due_date }
          end
          unless  @ticket.ticket_type.nil?
            tr do 
              td { b 'Ticket Type' }
              td { rawtext @ticket.ticket_type.name }
            end
          end
          
          if @ticket.comments.size > 0
            tr do
              td { br }
              td { br }
            end
              
            tr do 
              td { b 'Comments' }
              td { rawtext ''}
            end
            
            tr do
              td { br }
              td { br }
            end
            
            @ticket.comments.each do  |comment|
              tr do 
                td { b 'From' }
                td { rawtext "#{comment.user.person.fullname} - #{comment.created_at} " }
              end
              
              tr do 
                td { b 'Comment' }
                td { rawtext comment.body}
              end
              
              tr do
                td { br }
                td { br }
              end
              
            end
          end
        end

     end

     div do
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
              td {rawtext Person.find_by_modified_by_id(version.whodunnit).fullname unless Person.find_by_modified_by_id(version.whodunnit).nil?}
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
