class Views::FieldManager::Tickets::EditDetails < Erector::RailsWidget
  needs :ticket
  def content
    div :class => 'field' do
      label "Reported by"
      rawtext text_field_tag :person_lastname_firstname, ticket.reported_by.person.fullname, :size => 30, :onFocus=> "autocomplete_reporter();"
      br
      div :id => "reporter_details", :class => "prefix_3 grid_4" do
        #widget Views::Admin::Users::ShowJs.new(:user => ticket.reported_by)
      end
      rawtext hidden_field_tag 'ticket[reported_by_id]', ticket.reported_by.id
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
 #       widget Views::Links::ShowRecordJs, :record => ticket.link
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
      rawtext simple_select :ticket, :failure,  :selected => ticket.failure_id
      div ui_style(:button, {:class => "no_float", :id => "add_failure"}) do
        text "Add"
      end
      
      div :id => "add_failure_dialog", :title => "Add a failure", :style => 'display:none;' do
          label "Name"
          rawtext text_field_tag 'failure[name]'
          br
          rawtext submit_to_remote 'create_failure', 'Create', 
              :url => "/admin/failures/create", 
              :success => "$('#ticket_failure_id').replaceWith(request); $('#add_failure_dialog').dialog('close');",
              :submit => "add_failure_dialog"
      end
    end

    div :class => 'field' do
      label "Alarm description"
      rawtext text_area_tag :alarm, ticket.alarm
    end

    div :class => 'field' do
      label "Attended by"
      rawtext select :ticket, :attended_by_id, User.field_managers_collection.collect {|record| [record.person.fullname, record.id]}, :prompt => "-- Select Field Manager --", :selected => ticket.attended_by.id
    end

    div :class => 'field' do
      label "Recommended priority"
      rawtext simple_select :ticket, :priority, {:prompt => true, :selected => ticket.priority_id}
    end
    div :id => "add_edit_dialog"
  end
end
