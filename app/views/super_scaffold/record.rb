class Views::SuperScaffold::Record < Erector::RailsWidget
  needs :collection, :columns

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
        columns.keys.each do |column|
          th { text column }
        end
      end
    end
  end

  def table_body
    tbody do
      collection.each do |record|
        tr do
          td { text record.id }
          columns.keys.each do |column|
            td { text record.send(column) }
          end
        end
      end
    end
  end
end