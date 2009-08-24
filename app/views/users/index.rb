class Views::Users::Index < Views::Admin::Users::Index
  def page_title
    "User list"
  end
  
  def view_content
    form_tag 'users', :method => :get do
      b { text 'Sort by name:' }
      rawtext select 'order', nil, options_for_select([['Ascending', 'ASC'], ['Descending', 'DESC']], params[:order]),
        {}, {:onchange => "this.form.submit();"}
    end    
    widget Views::Admin::Users::Record, :collection => @collection
    paginator(@collection)
    rawtext link_to "Add user", {:action => 'new'}, ui_style(:button) if current_user.role_symbols.include? :field_manager
  end


end