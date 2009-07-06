class Views::Admin::SuperScaffold::Form < Erector::RailsWidget
  needs :f, :record
  
  def content
    div do
      text label "name"
      br
      rawtext f.text_field :name
    end
  end
  
end