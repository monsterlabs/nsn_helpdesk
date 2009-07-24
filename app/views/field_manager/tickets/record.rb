class Views::FieldManager::Tickets::Record < Erector::RailsWidget
  needs :collection

  def content
    table :id => "listing" do
      table_header
      table_body
    end
  end

  def table_header
    thead :class => "ui-widget-header", :id => "listing-head" do
      tr do
        %w(CaseID Region Link AffectedSites FrequencyTX FrequencyRX Priority Failure Alarms ReportedByCustomer FieldManager OpenedDate OpenedBy DueDate Status ResolvedDate CallsHandleTime Actions).each  do |column|
          th { text column }
        end
      end
    end
  end
  
  def table_body
    tbody do    
      @collection.each do |ticket|
         tr :id => ticket.dom_id do
            td { rawtext ticket.case_id  }
            td { rawtext ticket.link.region.name}
            td { rawtext ticket.link.sites}          
            td { rawtext ticket.affected_site}
            td { rawtext ticket.frequency_tx}          
            td { rawtext ticket.frequency_rx}
            td { rawtext ticket.priority.name}          
            td { rawtext ticket.failure.name}
            td { rawtext ticket.alarm}
            td { rawtext ticket.reported_by.person.fullname } 
            td { rawtext ticket.attended_by.person.fullname}
            td { rawtext ticket.opened_at}
#            ticket.opened_by.person == nil ? td { rawtext ""} : td { rawtext ticket.opened_by.person.fullname}
            td { rawtext ticket.due_date }
            td { rawtext ticket.status.name }
            ticket.status.id > 2 ? td { rawtext ticket.updated_at } : td { rawtext ""}
#           td { rawtext ticket.capture_time }
           td {
               link_to 'Edit', :action => 'edit', :id => ticket.id 
               text ' | '
               link_to 'Show', :action => 'show', :id => ticket.id
              }
         end
      end
    end
  end
end

