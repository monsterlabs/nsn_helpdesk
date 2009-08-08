class Views::Admin::Links::ShowJs < Views::Layouts::ApplicationJs
  include AuthenticationSystem
  def js_content
    rawtext hidden_field_tag 'ticket[link_id]', @link.id
    p do
      b { text "City"}
      text @link.city.name if @link.city
    end
    p do
      b { text "Frequency Tx"}
      text @link.frequency_tx
    end
    p do
      b { text "Frequency Rx"}
      text @link.frequency_rx
    end
    p do
      b { text "Time zone"}
      text @link.time_zone.name
    end
    p do
      b { text "Status"}
      text @link.current_status
    end
    link_to_remote("Edit", {:url => {:controller => 'links', :action => 'edit', :id => @link.id},
            :with => "'region_id=' + $('#customer_filter_region_id').val()",
            :update => {:success => "add_edit_dialog"}, 
            :success => '$("#add_edit_dialog").dialog({
              bgiframe: true,
              height: 280,
              modal: true,
              autoOpen: false,
              draggable: false,
              resizable: false
            }); 
            $("#add_edit_dialog").dialog("open");
            set_button_behaviour();'},
            ui_style(:button)) if (current_user.roles.first.name == "admin")
  end
end