class Views::Admin::Tickets::Record < Erector::RailsWidget
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
        %w(CaseID Region Link Affected Site Status Alarms Customer OpenedDate).each  do |column|
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
            td { rawtext ticket.affected_site }
            td { rawtext ticket.status.name }
            td { rawtext ticket.alarm }
            td { rawtext ticket.reported_by.person.fullname }
            td { rawtext ticket.opened_at}
           td {
               link_to 'Edit', :action => 'edit', :id => ticket.id 
               text ' | '
               link_to 'Show', :action => 'show', :id => ticket.id
               text ' | '    
               link_to 'Destroy', {:action => :destroy, :id => ticket.id}, :method => :delete, :confirm => 'Do you want to delete this record ?'
             }
         end
       end
    end
  end
end

