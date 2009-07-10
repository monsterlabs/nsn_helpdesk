class Views::Admin::Tickets::Show < Views::Layouts::Application
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
     end
   end
end
