class Views::Admin::Tickets::Index < Views::Layouts::Application

  def page_title
    "Tickets Index"
  end

  def view_content
    div do
      form_for(:q, :url => { :action => 'search_by_case_id'}) do |f|
        label "Search by key:"
      
        rawtext f.text_field :case_id, :size => 15
      end

      label "  Order by:"
      rawtext filter_select(:priority)
      rawtext filter_select(:status)
#      rawtext filter_select(:region)
      span :id => 'filter_selected' do
      end
    end    

    span :id =>"ticket_collection", :class => 'collection' do
      widget Views::Admin::Tickets::Record, :collection => @collection
      paginator @collection 
    end
    rawtext link_to 'Add ticket', {:action => 'new'}, ui_style(:button)    
  end
end
