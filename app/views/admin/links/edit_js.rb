class Views::Admin::Links::EditJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext error_messages_for 'record', :class => 'ui-state-error ui-corner-all'
    form_remote_tag(:url => "/admin/links/update", 
      :success => "$('#add_edit_dialog').dialog('close'); $('div#link_details').html(request);") do
        rawtext hidden_field_tag(:id, @link.id)
      p do
        label "City"
        rawtext collection_select :link, :city_id, City.region_id_equals(@region_id).sort {|x,y| x.name <=> y.name}, :id, :name
      end
      p do
        label "Sites"
        rawtext text_field_tag("link[sites]", @link.sites)
      end
      p do
        label "Frequency Tx"
        rawtext text_field_tag("link[frequency_tx]", @link.frequency_tx)
      end
      p do
        label "Frequency Rx"
        rawtext text_field_tag("link[frequency_rx]", @link.frequency_rx)
      end
      p do
        label "Time zone"
        rawtext collection_select :link, :time_zone_id, TimeZone.all, :id, :name
      end
      p do
        label "Status"
        rawtext text_field_tag("link[current_status]", @link.current_status)
      end
      rawtext submit_tag 'Update', ui_style(:button)
      a(ui_style(:button).merge({:onclick =>'$("#add_edit_dialog").dialog("close");'})) {text "Cancel"}
    end
  end
end