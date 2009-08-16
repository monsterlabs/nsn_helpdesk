class Views::Links::NewJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext error_messages_for 'record', :class => 'ui-state-error ui-corner-all'
    form_remote_tag(:url => "/links/create", 
    :success => "$('#link_details').html(request); $('#add_edit_dialog').dialog('close'); $('#sites').val($('#link_sites').val());") do
    div :id => 'link_progress' do
      widget Views::Links::Form, :record => @link
    end
      rawtext submit_tag 'Create', ui_style(:button)
      a(ui_style(:button).merge({:onclick =>'$("#add_edit_dialog").dialog("close");'})) {text "Cancel"}
    end
  end
end