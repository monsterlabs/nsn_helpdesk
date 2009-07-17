class Views::Helpers::Select < Erector::RailsWidget
  def content
    rawtext select('filter', 'selected_id', Region.all.collect {|p| [p.name, p.id]}, {:prompt => '-- Select Region --'})
    rawtext observe_field :filter_selected_id, :url => {:action => :filter_tickets}
  end
end
