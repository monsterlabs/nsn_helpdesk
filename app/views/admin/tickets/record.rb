class Views::Admin::Tickets::Record < Erector::RailsWidget
  needs :collection

  def content
    table :id => "listing" do
      table_header %w(Id Subject Status ReportedBy OpenedBy Priority Region Actions)
      table_body
    end
  end

  def table_body
    tbody do    
       @collection.each do |ticket|
         tr :id => ticket.dom_id do
           td { rawtext ticket.id  }
           td { rawtext ticket.subject }
           td { rawtext ticket.status.name }
           td { rawtext ticket.reported_by.person.fullname }
           td { rawtext ticket.opened_by.email }
           td { rawtext ticket.priority.name}
           td { rawtext ticket.region.name}
         end
       end
    end
  end
end

