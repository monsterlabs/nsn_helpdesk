class Views::People::RowPhoto < Erector::RailsWidget
  needs :person
  
  def content
    div :id => "photo_row" do
      rawtext "Photo: #{image_tag(@person.photo.url(:thumb))}"
      span :id => "link" do
        rawtext link_to_remote('Change Photo', :url => {:action => 'change_photo', :controller => 'people', :id => person.user.id})
      end
    end
  end
  
end