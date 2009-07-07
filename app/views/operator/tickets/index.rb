class Views::Operator::Tickets::Index < Views::Layouts::Application

  def page_title
    "Tickets Index"
  end

  def view_content
    rawtext link_to 'Add ticket', {:action => 'new'}, ui_style(:button)    
  end

end
