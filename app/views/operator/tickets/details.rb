class Views::Operator::Tickets::Details < Erector::RailsWidget

  def content
    div :class => 'field' do
      label "Reported by"
      rawtext text_field_tag :person_lastname_firstname
      rawtext hidden_field_tag :reported_by_id
    end
    div :class => 'field' do
      label "Link"
      rawtext text_field_tag :link_sites
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
      rawtext collection_select :ticket, :reported_priority_id, Priority.all, :id, :name, {:prompt => '-- Select --'}  
    end
    div :class => 'field' do
      label "Alarm description"
      rawtext text_field_tag :alarm
    end
    div :class => 'field' do
      label "Attended by"
      rawtext text_field_tag :person_lastname_firstname
      rawtext hidden_field_tag :reported_by_id
    end
  end
end
