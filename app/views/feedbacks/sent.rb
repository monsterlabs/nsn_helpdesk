class Views::Feedbacks::Sent < Views::Layouts::Application
  def page_title
    "Feedback"
  end
  
  def view_content
    p "Your report has been sent"
  end
end