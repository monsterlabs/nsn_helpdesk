class Views::Operator::Tickets::Form < Erector::RailsWidget
  def content
    div :class => 'field' do
      label "Reported by"
      rawtext f.select :reported_by_id, User.customers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  
    end
    div :class => 'field' do
      label "Link"
      rawtext f.collection_select :link_id, Link.all, :id, :sites, {:prompt => '-- Select --'}  
    end
  end
end
