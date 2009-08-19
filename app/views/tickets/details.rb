class Views::Tickets::Details < Erector::RailsWidget

  def content
    div :class => 'field' do
      label "Reported by"
      rawtext text_field_tag :person_lastname_firstname, nil, :size => 30
      link_to_remote("Add", {:url => {:controller => 'admin/users', :action => 'new'},
              :with => "'response_id=reporter_details&input_id=person_lastname_firstname'",
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
              set_button_behaviour();
              $("#user_person_attributes_region_id").val($("#customer_filter_region_id").val());'},
              ui_style(:button, {:class => "no_float"}))
      br
      div :id => "reporter_details", :class => "prefix_3 grid_4"
      rawtext hidden_field_tag 'ticket[reported_by_id]'
    end
    
    div :class => 'field' do
      label "Alternative contact"
      rawtext text_field_tag :alternate_person_lastname_firstname, nil, :size => 30
      link_to_remote("Add", {:url => {:controller => 'admin/users', :action => 'new'},
              :with => "'response_id=alternate_details&input_id=alternate_person_lastname_firstname'",
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
              set_button_behaviour();
              $("#user_person_attributes_region_id").val($("#customer_filter_region_id").val());'},
              ui_style(:button, {:class => "no_float"}))
      br
      div :id => "alternate_details", :class => "prefix_3 grid_4"
      rawtext hidden_field_tag 'ticket[alternate_contact_id]'
    end
    
    div :class => 'field' do
      label "Link"
      rawtext text_field_tag :sites, nil, :size => 40
      link_to_remote("Add", {:url => {:controller => 'admin/links', :action => 'new'},
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
              set_button_behaviour();
              $("#link_region_id").val($("#customer_filter_region_id").val());'},
              ui_style(:button, {:class => "no_float"})) if current_user.does_not_have_role? :operator
      rawtext hidden_field_tag 'ticket[link_id]'
      br
      label "Affected site"
      rawtext text_field_tag 'ticket[affected_site]'
      br
      div :id => "link_details", :class => "prefix_3 grid_4" do
        text ""
      end
    end
    
    div :class => 'field' do
      label "Special instructions"
      rawtext text_area_tag 'ticket[special_instructions]'
    end
    
    div :class => 'field' do
      label "Priority reported by customer"
      rawtext simple_select :ticket, :priority, {:prompt => true, :method_name => :reported_priority_id}
    end
    
    div :class => 'field' do
      label "Failure"
      rawtext simple_select :ticket, :failure
      div ui_style(:button, {:class => "no_float", :id => "add_failure"}) do
        text "Add"
      end
      div :id => "add_failure_dialog", :title => "Add a failure" do
        form_remote_tag(:url => "/admin/failures/create", :success => "$('#ticket_failure_id').replaceWith(request); $('#add_failure_dialog').dialog('close');") do
          label "Name"
          rawtext text_field_tag 'failure[name]'
          br
          rawtext submit_tag 'Create', ui_style(:button)
        end
      end
    end
    
    div :class => 'field' do
      label "Alarm description"
      rawtext text_area_tag 'ticket[alarm]'
    end
  
    div :class => 'field' do
      label "Attended by"
      rawtext select :ticket, :attended_by_id, User.field_managers_collection.collect {|record| [record.person.fullname, record.id]}, :prompt => "-- Select Field Manager --"
    end
    
    div :class => 'field' do
      label "Recommended priority"
      rawtext simple_select :ticket, :priority, {:prompt => true}
    end

    div :class => 'field' do
      label "Additional notes"
      rawtext text_area_tag 'ticket[notes]'
    end
    
    div :id => "add_edit_dialog"
  end
end
