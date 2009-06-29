class Views::UserSettings::Form < Erector::RailsWidget
  needs :f, :user
  
  def content
    div do
      text "Name:" + user.person.firstname
      text "Lastname:" + user.person.lastname1
      span :id => "photo_row" do
        if user.person.nil?
          div do 
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