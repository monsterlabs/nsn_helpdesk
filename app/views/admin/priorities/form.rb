class Views::Admin::Priorities::Form < Erector::RailsWidget
  needs :f, :priority
  
  def content
    div do
      text "name"
      rawtext f.text_field :name
    end
  end
  
end