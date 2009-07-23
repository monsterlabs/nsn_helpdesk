class Views::Operator::Tickets::Record < Erector::RailsWidget
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
        %w(CaseID Subject Status ReportedBy Region AttendedBy Priority Actions).each  do |column|
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
          td { rawtext ticket.failure.name }
          td { rawtext ticket.status.name }
          td { rawtext ticket.reported_by.person.fullname } 
          td { rawtext ticket.link.region.name}
          td { rawtext ticket.attended_by.person.fullname } 
          td { rawtext ticket.priority.name}
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

