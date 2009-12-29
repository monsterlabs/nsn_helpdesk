class Views::FieldManager::Tickets::EditDetails < Erector::RailsWidget
  needs :ticket

  def content
    jquery "autocomplete_reporter();
    autocomplete_alternate();
    autocomplete_link();"

    div :class => 'field' do
      label "Reported by"
      rawtext text_field_tag :person_lastname_firstname, ticket.reported_by.person.fullname, :size => 30, :disabled => "true"
      link_to_remote("Add", {:url => {:controller => 'admin/users', :action => 'new'},
      :with => "'response_id=reporter_details&associated_field_id=person_lastname_firstname&value_tag_id=ticket_reported_by_id'",
      :update => {:success => "add_edit_dialog"}, 
      :success => '$("#add_edit_dialog").dialog({
      bgiframe: true,
      height: 320,
      modal: true,
      autoOpen: false,
      draggable: false,
      resizable: false
      });
      $("#add_edit_dialog").dialog("open");
      $("#add_edit_dialog").dialog("enable");
      set_button_behaviour();
      $("#user_person_attributes_region_id").val($("#customer_filter_region_id").val());'},
      ui_style(:button, {:class => "no_float"}))
      br
      div :id => "reporter_details", :class => "prefix_3 grid_4" do
        widget Views::Admin::Users::ShowJs, :user => ticket.reported_by, :value_tag_id => 'ticket_reported_by_id', :associated_field_id => 'person_lastname_firstname', :response_id => 'reporter_details'
      end
      rawtext hidden_field_tag 'ticket[reported_by_id]', ticket.reported_by.id
    end

    unless  ticket.alternate_contact.nil?
      div :class => 'field' do
        label "Alternative contact"
        rawtext text_field_tag :alternate_person_lastname_firstname, ticket.alternate_contact.person.fullname, :size => 30, :disabled => "true"
        link_to_remote("Add", {:url => {:controller => 'admin/users', :action => 'new'},
        :with => "'response_id=alternate_details&associated_field_id=alternate_person_lastname_firstname&value_tag_id=ticket_alternate_contact_id'",
        :update => {:success => "add_edit_dialog"}, 
        :success => '$("#add_edit_dialog").dialog({
        bgiframe: true,
        height: 320,
        modal: true,
        autoOpen: false,
        draggable: false,
        resizable: false
        });
        $("#add_edit_dialog").dialog("open");
        $("#add_edit_dialog").dialog("enable");
        set_button_behaviour();
        $("#user_person_attributes_region_id").val($("#customer_filter_region_id").val());'},
        ui_style(:button, {:class => "no_float"}))
        br
        div :id => "alternate_details", :class => "prefix_3 grid_4" do
          widget Views::Admin::Users::ShowJs, :user => ticket.alternate_contact, :value_tag_id => 'ticket_alternate_contact_id', :associated_field_id => 'alternate_person_lastname_firstname', :response_id => 'alternate_details'
        end
        rawtext hidden_field_tag 'ticket[alternate_contact_id]', ticket.alternate_contact.id
      end
    end

    div :class => 'field' do
      label "Link"
      rawtext text_field_tag :sites, ticket.link.sites, :size => 40, :onFocus=> "autocomplete_link();"
      link_to_remote("Add", {:url => {:controller => 'links', :action => 'new'},
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
      ui_style(:button, {:class => "no_float"}))
      br
      label "Affected site"
      rawtext text_field_tag 'ticket[affected_site]', ticket.affected_site
      br
      div :id => "link_details", :class => "prefix_3 grid_4" do
        widget Views::Links::ShowRecordJs, :record => ticket.link
      end
    end

    div :class => 'field' do
      label "Special instructions"
      rawtext text_area_tag 'ticket[special_instructions]', ticket.special_instructions
    end

    div :class => 'field' do
      label "Priority reported by customer"
      rawtext simple_select :ticket, :priority,  {:prompt => true, :selected => ticket.reported_priority_id, :method_name => :reported_priority_id }
    end

    div :class => 'field' do
      label "Failure"
      rawtext collection_select('ticket', :failure_id, Failure.all, :id, :failure_length_limited, :selected => ticket.failure_id)

      div ui_style(:button, {:class => "no_float", :id => "add_failure"}) do
        text "Add"
      end

      div :id => "add_failure_dialog", :title => "Add a failure", :style => 'display:none;' do
        label "Name"
        rawtext text_field_tag 'failure[name]'
        br

        a(ui_style(:button).merge({:onclick =>"$.ajax({data:$(\"#add_failure_dialog :input\").serialize(), dataType:'script', success:function(request){$('#ticket_failure_id').replaceWith(request); $('#add_failure_dialog').dialog('close');}, type:'post', url:'/admin/failures/create'});"})) {text "Create"}
      end
    end

    div :class => 'field' do
      label "Alarm description"
      rawtext text_area_tag 'ticket[alarm]', ticket.alarm
    end

    div :class => 'field' do
      label "Attended by"
      rawtext select :ticket, :attended_by_id, User.field_managers.collect {|record| [record.person.fullname, record.id]}, :prompt => "-- Select Field Manager --", :selected => ticket.attended_by.id
    end

    div :class => 'field' do
      label "Recommended priority"
      rawtext simple_select :ticket, :priority, {:prompt => true, :selected => ticket.priority_id}
    end

    div :class => 'field' do
      label "Additional notes"
      rawtext text_area_tag 'ticket[notes]', ticket.notes
    end

    div :id => "add_edit_dialog"
  end
end
