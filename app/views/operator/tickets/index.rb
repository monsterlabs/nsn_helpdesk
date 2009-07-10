class Views::Operator::Tickets::Index < Views::Layouts::Application

  def page_title
    "Tickets Index"
  end

  def view_content
    widget Views::Operator::Tickets::Record, :collection => @collection
    paginator @collection
    rawtext link_to 'Add ticket', {:action => 'new'}, ui_style(:button)    
  end

end
