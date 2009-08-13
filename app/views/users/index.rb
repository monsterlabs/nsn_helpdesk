class Views::Users::Index < Views::Admin::Users::Index
  def page_title
    "User list"
  end
  
  def view_content
    widget Views::Admin::Users::Record, :collection => @collection
    paginator(@collection)
    rawtext link_to "Add user", {:action => 'new'}, ui_style(:button) if current_user.role_symbols.include? :field_manager
  end


end