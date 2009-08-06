class Views::FieldManager::Tickets::Details < Erector::RailsWidget

  def content
    div :class => 'field' do
      label "Reported by"
      rawtext text_field_tag :person_lastname_firstname, nil, :size => 30
      rawtext hidden_field_tag 'ticket[reported_by_id]'
    end
    
    div :class => 'field' do
      label "Link"
      rawtext text_field_tag :link_sites, nil, :size => 40
      rawtext hidden_field_tag 'ticket[link_id]'
      label "Affected site"
      rawtext text_field_tag 'ticket[affected_site]'
    end
    
    div :class => 'field' do
      label "Special instructions"
      rawtext text_area_tag 'ticket[special_instructions]'
    end
    
    div :class => 'field' do
      label "Frequency TX"
      rawtext text_field_tag 'ticket[frequency_tx]'
    end
    
    div :class => 'field' do
      label "Frequency RX"
      rawtext text_field_tag 'ticket[frequency_rx]'
    end

    div :class => 'field' do
      label "Priority reported by customer"
      rawtext simple_select :ticket, :priority, :reported_priority_id, {:prompt => true}
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
      rawtext text_area_tag :alarm
    end

    div :class => 'field' do
      label "Attended by"
      rawtext select :ticket, :attended_by_id, User.field_managers_collection.collect {|record| [record.person.fullname, record.id]}, :prompt => "-- Select Field Manager --"
    end
    
    div :class => 'field' do
      label "Recommended priority"
      rawtext simple_select :ticket, :priority, nil, {:prompt => true}
    end
  end
end
