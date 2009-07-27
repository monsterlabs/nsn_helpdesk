class Views::Operator::Tickets::Index < Views::Layouts::Application

  def page_title
    "Tickets Index"
  end

  def body_content
    feedback
    div :class => "container_16" do
      ## Create the layout
      header_bar
      toplinks
      dashboard
      ## This is where the view sets its content
      div :class => "grid_15 suffix_1" do
        view_content
        dialog
      end
      div :class => "clear"
      footer
    end
  end

  def view_content
    div :id => "search" do
      form_for(:q, :url => { :action => 'search_by_case_id'}) do |f|
        label "Search by key:"

        rawtext f.text_field :case_id, :size => 15
      end

      div :id => "filter" do 
        label "  Order by:"
        rawtext filter_select(:priority)
        rawtext filter_select(:status)
        rawtext link_to 'Show all', {:action => 'index'}, ui_style(:button)
      end

      span :id => 'filter_selected' do
      end
    end    
    span :id =>"ticket_collection", :class => 'collection' do
      widget Views::Operator::Tickets::Record, :collection => @collection
      paginator @collection
    end
    rawtext link_to 'Add ticket', {:action => 'new'}, ui_style(:button)    
  end

end
