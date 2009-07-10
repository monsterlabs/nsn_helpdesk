class Views::Admin::Users::Index < Views::Layouts::Application
  def page_title
    "User Administration"
  end
  
  def view_content
    widget Views::Admin::Users::Record, :collection => @collection
    paginator(@collection)
    rawtext link_to "Add user", {:action => 'new'}, ui_style(:button)
  end


end