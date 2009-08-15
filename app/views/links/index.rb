class Views::Links::Index < Views::Layouts::Application

  def page_title
    "Links Index"
  end

  def view_content
      span :id =>"links_collection", :class => 'collection' do
        widget Views::Links::Table, :collection => @collection
        paginator(@collection)
      end
      
      rawtext link_to 'Add link', {:action => 'new'}, ui_style(:button)    
  end
end
