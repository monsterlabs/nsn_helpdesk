class Views::Admin::Priorities::Index < Views::Layouts::Application
  def page_title
    "Priorities"
  end
  
  def view_content
    h1 { text "Priorities" }
    
    widget Views::Admin::Priorities::Record, :collection => @collection

    rawtext link_to "Add", {:action => 'new'}, ui_style(:button)
  end


end