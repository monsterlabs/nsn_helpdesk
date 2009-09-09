class Views::Admin::Users::Index < Views::Layouts::Application
  def page_title
    "User Administration"
  end
  
  def view_content
    form_tag 'users', :method => :get do
      b { text 'Sort by name:' }
      rawtext select 'filter', 'order', options_for_select([['Ascending', 'ASC'], ['Descending', 'DESC']],
        (params[:filter] ? params[:filter][:order] : '')),
        {}, {:onchange => "this.form.submit();"}
      br
      b { text 'Role:' }
      rawtext select 'filter', 'role', options_for_select(Role.all.map{ |role| [role.name.humanize, role.id.to_s] },
       (params[:filter] ? params[:filter][:role] : '')),
        {:include_blank => 'Any'}, {:onchange => "this.form.submit();"}
      br
      b {text "Region:"}
      rawtext select 'filter', 'region', options_for_select(Region.all.map{ |region| [region.name, region.id.to_s] },
        (params[:filter] ? params[:filter][:region] : '')),
        {:include_blank => 'Any'}, {:onchange => "this.form.submit();"}
      widget Views::Admin::Users::Record, :collection => @collection
    end
    paginator(@collection)
    rawtext link_to "Add user", {:action => 'new'}, ui_style(:button)
  end


end