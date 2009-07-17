class Views::Admin::Tickets::Index < Views::Layouts::Application

  def page_title
    "Tickets Index"
  end

  def view_content
    div do
      label "Search by key:"
      rawtext text_field_tag 'search', '', :size => 7, :maxlength => 8
      label "  Order by:"
      rawtext filter_select(:priority)
      rawtext filter_select(:status)
      rawtext filter_select(:region)
      span :id => 'filter_selected' do
      end
    end    

    span :id =>"ticket_collection", :class => 'collection' do
      widget Views::Admin::Tickets::Record, :collection => @collection
      paginator @collection 
    end
    rawtext link_to 'Add ticket', {:action => 'new'}, ui_style(:button)    
  end

  def filter_select(class_name)
    collection_select(:filter, classify(class_name).foreign_key, classify(class_name).constantize.all, :id, :name, {:prompt => true})
  end

  def classify(class_name)
     ActiveSupport::Inflector.tableize(class_name).classify
  end
end
