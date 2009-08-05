class Views::Admin::Links::Index < Views::Layouts::Application

  def view_content
    table :id => "listing" do
      
      thead :class => "ui-widget-header", :id => "listing-head" do
        tr  do
          th {text "Sites"}
          th {text "Frequency Tx"}
          th {text "Frequency Rx"}
          th {text "Current Status"}
          th {text "Time Zone"}
          th {text "Actions"}
        end
      end
      
      @collection.each do |record|
        tr :id => record.dom_id do
          td { text record.sites }
          td { text record.frequency_tx }
          td { text record.frequency_rx }
          td { text record.current_status }
          td { text record.time_zone.name }
          td :class => "actions_column" do 
            link_to 'Edit', {:action => :edit, :id => record.id}, ui_style(:button)
            link_to 'Show', {:action => :show, :id => record.id}, ui_style(:button)
            link_to 'Destroy', {:action => :destroy, :id => record.id}, 
                {:method => :delete, :confirm => 'Do you want to delete this record ?'}.merge(ui_style(:button))
          end
        end
      end
    end
    
    paginator(@collection)          
  end
end
