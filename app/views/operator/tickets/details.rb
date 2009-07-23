class Views::Operator::Tickets::Details < Erector::RailsWidget

  def content
    div :class => 'field' do
      label "Reported by"
      rawtext text_field_tag :person_lastname_firstname, nil, :size => 30
      rawtext hidden_field_tag :reported_by_id
    end
    div :class => 'field' do
      label "Link"
      rawtext text_field_tag :link_sites, nil, :size => 40
      rawtext hidden_field_tag :link_id
      label "Affected site"
      rawtext text_field_tag :affected_site
    end
    div :class => 'field' do
      label "Frequency TX"
      rawtext text_field_tag :frequency_tx
    end
    div :class => 'field' do
      label "Frequency RX"
      rawtext text_field_tag :frequency_rx
    end
    div :class => 'field' do
      label "Priority reported by user"
      rawtext simple_select :ticket, :priority, :reported_priority_id, {:prompt => true}
    end
    
    div :class => 'field' do
      label "Failure"
      rawtext simple_select :ticket, :failure
    end
    
    div :class => 'field' do
      label "Alarm description"
      rawtext text_area_tag :alarm
    end
    div :class => 'field' do
      label "Attended by"
      #rawtext collection_select :ticket, :attended_by_id, User.field_managers, :id,
      rawtext select :ticket, :attended_by_id, User.field_managers.collect {|record| [record.person.fullname, record.id] }
    end
  end
end
