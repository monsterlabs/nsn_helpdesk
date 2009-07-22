class Views::FieldManager::Tickets::Details < Erector::RailsWidget

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
  end
end
