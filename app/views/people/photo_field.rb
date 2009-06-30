class Views::People::PhotoField < Erector::RailsWidget
  needs :person
  
  def content
    div :id => "link" do
      rawtext file_field_tag :firstname
      link_to_remote 'Update photo', :url => { :controller => 'people', :action => 'update_photo', :id => person.id}
    end
  end
end