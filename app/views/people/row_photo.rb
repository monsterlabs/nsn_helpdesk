class Views::People::RowPhoto < Erector::RailsWidget
  needs :person
  
  def content
    div :id => "photo_row" do
      rawtext "Photo: #{image_tag(person.photo.url(:thumb))}"
      span :id => "link" do
        rawtext link_to_remote('Change Photo', 
                {:url => change_photo_person_path(person), :method => :get },
                ui_style(:button))
      end
    end
  end
end