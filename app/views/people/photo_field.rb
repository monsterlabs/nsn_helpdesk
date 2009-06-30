class Views::People::PhotoField < Erector::RailsWidget
  needs :person
  
  def content
    div :id => "link" do
      rawtext file_field_tag :firstname
      link_to_remote 'Update photo', :url => update_photo_person_path(person), :method => :get
    end
  end
end