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
#        th { text "id" }
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
        tr do
          columns.keys.each do |column|
            td { text record.send(column) }
          end
          td do 
            link_to 'Edit', :action => :edit, :id => record.id
            text ' | '
            link_to 'Show', :action => :show, :id => record.id
            text ' | '
            link_to 'Destroy', :action => :show, :id => record.id
        end
        end
      end
    end
  end
end
