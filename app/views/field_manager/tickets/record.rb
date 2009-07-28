class Views::FieldManager::Tickets::Record < Erector::RailsWidget
  needs :collection

  def content
    table :id => "listing", :class => "tickets-table" do
      table_header
      table_body
    end
  end

  def table_header
    thead :class => "ui-widget-header", :id => "listing-head" do
      tr do
        %w(case_id region link affected_site status alarms customer opened_date actions).each  do |column|
          th :id => column do
            text ActiveSupport::Inflector.humanize(column)
          end
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
            td { if ticket.affected_site.empty? then text "Both" else text ticket.affected_site end }
            td { rawtext ticket.frequency_tx}          
            td { rawtext ticket.frequency_rx}
            td { rawtext ticket.priority.name}          
            td { rawtext ticket.failure.name}
            td { rawtext ticket.alarm}
            td { rawtext ticket.reported_by.person.fullname } 
            td { rawtext ticket.attended_by.person.fullname}
            td { rawtext ticket.opened_at}
            td { if ticket.opened_by.person.nil? then text ticket.opened_by.login else text ticket.opened_by.person.fullname end}
            td { rawtext ticket.due_date }
            td { rawtext ticket.status.name }
            ticket.status.id > 2 ? td { rawtext ticket.updated_at } : td { rawtext ""}
            td { rawtext ticket.capture_time }
            td {
              link_to 'Edit', {:action => :edit, :id => ticket.id}, ui_style(:button)
              link_to 'Show', {:action => :show, :id => ticket.id}, ui_style(:button)
            }
         end
      end
    end
  end
end

