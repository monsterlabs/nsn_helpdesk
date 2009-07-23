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
        %w(CaseID Subject Status ReportedBy OpenedBy Region Priority Actions).each  do |column|
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
          unless ticket.reported_by.nil?
            td { rawtext ticket.reported_by.person.fullname } 
            td { rawtext ticket.opened_by.person.fullname }
            td { rawtext ticket.link.region.name}
            else
            td { label "" } 
            td { label "Not opened"}
            td { label ""}
          end
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

