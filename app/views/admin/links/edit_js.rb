class Views::Admin::Links::EditJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext error_messages_for 'record', :class => 'ui-state-error ui-corner-all'
    form_remote_tag(:url => "/admin/links/update/#{@record.id}", 
      :success => "\
      $('#add_edit_dialog').dialog('close');\
      $.ajax({ url: \"../links/show\", data: {id: $(\"#ticket_link_id\").val()},
        success: function(request) { $(\"div#link_details\").html(request)} });") do
      p do
        label "Sites"
        rawtext text_field_tag(:sites, @record.sites)
      end
      p do
        label "Frequency Tx"
        rawtext text_field_tag(:frequency_tx, @record.frequency_tx)
      end
      p do
        label "Frequency Rx"
        rawtext text_field_tag(:frequency_rx, @record.frequency_rx)
      end
      p do
        label "Status"
        rawtext text_field_tag(:current_status, @record.current_status)
      end
      rawtext submit_tag 'Update', ui_style(:button)
      a(:onclick =>'$("#add_edit_dialog").dialog("close");') {text "Cancel"}
    end
  end
end