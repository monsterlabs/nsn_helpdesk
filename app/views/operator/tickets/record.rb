class Views::Operator::Tickets::Record < Erector::RailsWidget
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
          td { rawtext ticket.status.name }
          td { rawtext ticket.alarm }
          td { rawtext ticket.reported_by.person.fullname }
          td { rawtext ticket.opened_at}
          td { rawtext link_to 'Show', {:action => 'show', :id => ticket.id}, ui_style(:button) }
        end
      end
    end
  end
end

