class Views::Links::EditJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext error_messages_for 'record', :class => 'ui-state-error ui-corner-all'
    form_remote_tag(:url => "/links/update",
      :loading => "show_progress()",
      :complete => "hide_progress();",
      :success => "
        $('#sites').val($('#link_sites').val());
        $('#add_edit_dialog').dialog('close');
        $('div#link_details').html(request);"
      ) do |f|
        widget Views::Links::Form, :record => @link
        rawtext submit_tag 'Update', ui_style(:button)
        a(ui_style(:button).merge({:onclick =>'$("#add_edit_dialog").dialog("close");'})) {text "Cancel"}
    end
  end
end