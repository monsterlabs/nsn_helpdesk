class Views::Admin::Links::ShowJs < Views::Layouts::ApplicationJs
  def js_content
    p do
      b { text "City"}
      text @record.city.name
    end
    p do
      b { text "Frequency Tx"}
      text @record.frequency_tx
    end
    p do
      b { text "Frequency Rx"}
      text @record.frequency_rx
    end
    p do
      b { text "Status"}
      text @record.current_status
    end
    link_to_remote("Edit", {:url => {:controller => 'links', :action => 'edit', :id => @record.id},
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
            ui_style(:button))
  end
end