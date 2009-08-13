class Views::Tickets::Record < Erector::RailsWidget
  needs :collection

  def content
    @collection.each do |ticket|
      tr :id => ticket.dom_id do
        td { rawtext ticket.case_id  }
        td { rawtext ticket.link.region.name}
        td { rawtext ticket.link.sites}
        td { if ticket.affected_site.empty? then text "Both" else text ticket.affected_site end }
        td :id => 'status_' + ticket.dom_id do
           rawtext ticket.status.name 
        end
        td { rawtext ticket.reported_priority.name }
        td { rawtext ticket.priority.name }
        td { rawtext ticket.reported_by.person.fullname }
        td { rawtext ticket.opened_at}
        td { rawtext ticket.opened_at_local}

        td :class => "actions_column" do 
          if current_user.role_symbols.include? :admin
            link_to 'Edit', { :action => :edit, :id => ticket.id }, ui_style(:button)
            link_to 'Show', { :action => :show, :id => ticket.id }, ui_style(:button)
            link_to 'Destroy', { :action => :destroy, :id => ticket.id },
            { :method => :delete, :confirm => 'Do you want to delete this record ?' }.merge(ui_style(:button))
          elsif current_user.role_symbols.include? :field_manager
            link_to 'Edit', { :action => :edit, :id => ticket.id }, ui_style(:button)
            link_to 'Show', { :action => :show, :id => ticket.id }, ui_style(:button)
          else
            link_to 'Show', { :action => 'show', :id => ticket.id}, ui_style(:button) 
          end
        end
        if current_user.role_symbols.include? :field_manager
          td :class => "change_status_column" do
            Status.all(:conditions => 'id > 1', :order => 'id ASC').each do |s|
              link_to_remote(s.name, {:url => {:controller => '/field_manager/tickets', :action => 'edit_change_status', :status_id => s.id, :id => ticket.id}, :method => :get,
              :update => {:success => "add_edit_dialog"}, 
              :success => '$("#add_edit_dialog").dialog({
              bgiframe: true,
              height: 330,
              width: 340,
              modal: true,
              autoOpen: false,
              draggable: false,
              resizable: false
              }); 
              $("#add_edit_dialog").dialog("open");
              set_button_behaviour();
              '},
              ui_style(:button))

            end
          end
        end

      end
    end
  end
end

