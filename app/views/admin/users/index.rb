class Views::Admin::Users::Index < Views::Layouts::Application
  def page_title
    "User Administration"
  end
  
  def view_content
    form_tag 'users', :method => :get do
      b { text 'Sort by name:' }
      rawtext select 'order', nil, options_for_select([['Ascending', 'ASC'], ['Descending', 'DESC']], params[:order]),
        {}, {:onchange => "this.form.submit();"}
      
      widget Views::Admin::Users::Record, :collection => @collection
    end
    paginator(@collection)
    rawtext link_to "Add user", {:action => 'new'}, ui_style(:button)
  end


end