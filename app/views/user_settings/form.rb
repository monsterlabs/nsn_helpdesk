class Views::UserSettings::Form < Erector::RailsWidget
  needs :user
  
  def content
    div do
      text "Name:" + user.person.firstname
      text "Lastname:" + user.person.lastname1
      span do
        if user.person.nil?
          div :id => "photo_row" do 
            text "Photo"
            person.file_field :photo
          end
        else
          widget Views::People::RowPhoto, :person => user.person
        end
      end
    end
  end
  
end