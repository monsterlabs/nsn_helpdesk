class Views::Admin::SuperScaffold::Record < Erector::RailsWidget
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
        th { text "id" }
        th { text "name" }
      end
    end
  end

  def table_body
    tbody do
      collection.each do |record|
        tr do
          td { text record.id }
          td { text record.name }
        end
      end
    end
  end
end