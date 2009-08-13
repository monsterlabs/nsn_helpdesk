class Views::FieldManager::Tickets::EditChangeStatusJs < Views::Layouts::ApplicationJs
  def js_content
     rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
      form_remote_tag(:url => "/field_manager/tickets/change_status", 
        :success => "
          $('#sites').val($('#link_sites').val());
          $('#add_edit_dialog').dialog('close');
          $('div#link_details').html(request);") do |f|
          rawtext hidden_field_tag(:id, @ticket.id) 
          fieldset do
            div :class => 'field' do
              b "Case Id: "
              text @ticket.case_id
            end
            div :class => 'field' do
              b "Reported by: "
              text @ticket.reported_by.person.fullname
            end
            div :class => 'field' do
              b "Current status: "
              text @ticket.status.name
            end
            @status = Status.find(params[:status_id])
            div :class => 'field' do
              b "Change status to: "
              text @status.name
              rawtext hidden_field_tag 'ticket[status_id]', @status.id
            end
            
            div :class => 'field' do
              mylabel = (@status.id == 2 ? 'Assigned to: ' : "#{@status.name} by: ")
              b mylabel
              rawtext select :ticket, :assigned_to_id, User.field_managers_collection.collect {|record| [record.person.fullname, record.id]}, :prompt => "-- Select Field Manager --", :selected => current_user.id
            end
            
            if @status.id == 4 
              div :class => 'field' do
                b 'Accepts closing: '
                rawtext text_field_tag :person_lastname_firstname, @ticket.reported_by.person.fullname, :size => 30, :onFocus=> "autocomplete_reporter();"
                rawtext hidden_field_tag 'ticket[reported_by_id]', @ticket.reported_by.id
                #rawtext hidden_field_tag 'ticket[accepts_clossing_id]'
              end         
            end
            div :class => 'field' do
               b "Comments"
               br
               rawtext text_area_tag 'ticket[comments_attributes][0][body]'
               rawtext hidden_field_tag 'ticket[comments_attributes][0][user_id]', current_user.id
            end
          end
          rawtext submit_tag 'Change status', ui_style(:button)
          a(ui_style(:button).merge({:onclick =>'$("#add_edit_dialog").dialog("close");'})) {text "Cancel"}
      end
  end
end