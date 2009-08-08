class Views::Admin::Links::NewJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext error_messages_for 'record', :class => 'ui-state-error ui-corner-all'
    form_remote_tag(:url => "/admin/links/create", 
      :success => "\
      $('#add_edit_dialog').dialog('close');\
      $.ajax({ url: \"../links/show\", data: {id: $(\"#ticket_link_id\").val()},
        success: function(request) { $(\"div#link_details\").html(request)} });") do
      p do
        label "Sites"
        rawtext text_field_tag(:sites)
      end
      p do
        label "Frequency Tx"
        rawtext text_field_tag(:frequency_tx)
      end
      p do
        label "Frequency Rx"
        rawtext text_field_tag(:frequency_rx)
      end
      p do
        label "Time zone"
        rawtext collection_select :link, :time_zone_id, TimeZone.all, :id, :name
      end
      p do
        label "Status"
        rawtext text_field_tag(:current_status)
      end
      rawtext submit_tag 'Update', ui_style(:button)
      a(ui_style(:button).merge({:onclick =>'$("#add_edit_dialog").dialog("close");'})) {text "Cancel"}
    end
  end
end