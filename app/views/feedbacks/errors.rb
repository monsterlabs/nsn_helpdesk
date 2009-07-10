class Views::Feedbacks::Errors < Views::Layouts::Application
  def page_title
    "Feedback"
  end
  
  def view_content
    p "An error has ocurred when I've tried to send your report"
  end
end