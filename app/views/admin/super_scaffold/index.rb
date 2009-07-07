class Views::Admin::SuperScaffold::Index < Views::Layouts::Application
  def page_title
    ""
  end
  
  def view_content
    # h1 { text "Model Name" }
    
    widget Views::Admin::SuperScaffold::Record, :collection => @collection

    rawtext link_to "Add", {:action => 'new'}, ui_style(:button)
  end


end