class Views::Feedback::Form < Erector::RailsWidget
  
  def content
   form_tag('/feedbacks') do
      rawtext label { text "Title" }
      br
      rawtext text_field_tag('title')
      br
      rawtext label { text "Mesage" }
      br
      rawtext text_area_tag('message')
      
      rawtext submit_tag('Send', ui_style(:button, :id => "main"))
    end
  end
  
end