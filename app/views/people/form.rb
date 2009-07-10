class Views::People::Form < Erector::RailsWidget
  needs :f, :record
  
  def content
    div do
      p {
        rawtext f.label "Firstname"
        br
        rawtext f.text_field :firstname
        }
      p {
        rawtext f.label "Lastname"
        br      
        rawtext f.password_field :lastname
      }
    end
  end
  
end
