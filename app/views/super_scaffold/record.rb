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
        columns.keys.each do |column|
          th { text column }
        end
        th { text 'Actions' }
      end
    end
  end

  def table_body
    tbody do
      collection.each do |record|
        tr :id => record.dom_id do
          columns.keys.each do |column|
            td { text record.send(column) }
          end
          td do 
            link_to 'Edit', {:action => :edit, :id => record.id}, ui_style(:button)
            link_to 'Show', {:action => :show, :id => record.id}, ui_style(:button)
            link_to 'Destroy', {:action => :destroy, :id => record.id}, 
                {:method => :delete, :confirm => 'Do you want to delete this record ?'}.merge(ui_style(:button))
          end
        end
      end
    end
  end
end
