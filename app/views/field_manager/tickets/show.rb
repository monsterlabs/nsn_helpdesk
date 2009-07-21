class Views::FieldManager::Tickets::Show < Views::Layouts::Application
  def page_title
     "Show Ticket"
   end

   def view_content
     table :id => "show" do
       tr do 
           td { b 'Id' }
           td { rawtext @ticket.id }
        end

        tr do 
            td { b 'Subject' }
            td { rawtext @ticket.subject }
        end

        tr do 
            td { b 'Message' }
            td { rawtext  @ticket.body }
        end

        tr do 
            td { b 'Status' }
            td { rawtext @ticket.status.name }
        end

        tr do 
            td { b 'Reported by' }
            td { rawtext @ticket.reported_by.person.fullname }
        end

        tr do 
            td { b 'Company' }
            td { rawtext @ticket.reported_by.person.company.name }
        end

        tr do 
            td { b 'Opened by' }
            td { rawtext @ticket.opened_by.email }
        end

        tr do 
            td { b 'Priority' }
            td { rawtext @ticket.priority.name }
        end

        tr do 
            td { b 'Region' }
            td { rawtext @ticket.region.name }
        end
     end

     div do
       rawtext link_to('Modify', {:action => 'edit', :id => @ticket.id}, ui_style(:button))
       rawtext link_to('Cancel', {:action => 'index'}, ui_style(:button))
     end

     max_index = @ticket.versions.size - 1     
     if max_index > 0
       table :id => "header" do
         tr do 
           td { label h3 "This ticket has been modified #{max_index} time(s)."}
         end
       end
       
       (1..max_index).to_a.reverse.each do |i|
         table :id => "versions" do
           version = @ticket.versions[i]
           tr do
             td {label "Modification #{version.index}:"}
           end
           tr do
             td {label "Modified by:"}
             td {rawtext Person.find_by_user_id(version.whodunnit).fullname unless Person.find_by_user_id(version.whodunnit).nil?}
           end
           tr do
             td {label "IP Address:"}
             td {rawtext @ticket.versions[i].object.split(/\n/).map {|part| part.split[1] if part.match(/ip_address/)}}
           end
           tr do
             td {label "Status:"}
             td {rawtext @ticket.versions[i].object.split(/\n/).map {|part| Status.find(part.split[1]).name if part.match(/status/)}}
           end
           tr do
             td {label "Event"}
             td {rawtext version.event}
           end
           tr do
             td {label "Modified at"}
             td {rawtext version.created_at :short}
           end
         end
       end
     end
   end
end
