class Views::Links::Record < Views::Layouts::Application
  needs :collection

  def content
    @collection.each do |record|
      tr :id => record.dom_id do
        td { text record.sites }
        td { text record.frequency_tx }
        td { text record.frequency_rx }
        td { text record.region.name }
        td { text record.configuration }
        td { text record.city.name }
        td :class => "actions_column" do 
          link_to 'Edit', {:action => :edit, :id => record.id}, ui_style(:button)
          link_to 'Show', {:action => :show, :id => record.id}, ui_style(:button)
          if current_user.role_symbols.include? :admin
            link_to 'Destroy', {:action => :destroy, :id => record.id}, 
            {:method => :delete, :confirm => 'Do you want to delete this record ?'}.merge(ui_style(:button))
          end
        end
      end
    end
  end
end
