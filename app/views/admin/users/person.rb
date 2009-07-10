class Views::Admin::Users::Person < Erector::RailsWidget
  needs :f, :user
  
  def content
    f.fields_for 'person_attributes', user.person do |person|
       div :class => 'field' do
        label "Firstname"
        rawtext person.text_field :firstname 
      end
       div :class => 'field' do
        label "Lastname"
        rawtext person.text_field :lastname
      end
      if user.person.nil?
         div :class => 'field' do
          label "Photo"
          rawtext person.file_field :photo
        end
      else
         div :class => 'field' do
          label "Photo"
          rawtext image_tag user.person.photo.url(:thumb)
        end
      end
    end
  end
  
end