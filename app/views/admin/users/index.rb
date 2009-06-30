class Views::Admin::Users::Index < Views::Layouts::Application
  def page_title
    "Users"
  end
  
  def view_content
    div { text "Users:" }
    
    widget Views::Admin::Users::Record, :collection => @collection

    rawtext link_to "Add user", {:action => 'new'}, ui_style(:button)
  end


end