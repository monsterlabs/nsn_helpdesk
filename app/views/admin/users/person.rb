class Views::Admin::Users::Person < Erector::RailsWidget
  needs :f, :user
  
  def content
    f.fields_for 'person_attributes', user.person do |person|
      div do
        text "Name"
        rawtext person.text_field :firstname 
      end
      div do
        text "Last name"
        rawtext person.text_field :lastname
      end
      if user.person.nil?
        div do
          text "Photo"
          rawtext person.file_field :photo
        end
      else
        div do
          text "Photo"
          rawtext image_tag user.person.photo.url(:thumb)
        end
      end
    end
  end
  
end