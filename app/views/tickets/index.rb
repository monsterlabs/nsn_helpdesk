class Views::Tickets::Index < Views::Layouts::Application

  def page_title
    "Tickets Index"
  end

  def view_content
    span :id =>"ticket_collection", :class => 'collection' do
      widget Views::Tickets::Table, :collection => @collection
       div :id => "add_edit_dialog"
    end
    rawtext link_to 'Add ticket', {:action => 'new'}, ui_style(:button) unless current_user.roles.first.name == 'corporate'
  end

end
