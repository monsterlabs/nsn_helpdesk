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
      div :class => "grid_16" do
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
    end    
    
    span :id =>"ticket_collection", :class => 'collection' do
      widget Views::Operator::Tickets::Table, :collection => @collection
    end
    rawtext link_to 'Add ticket', {:action => 'new'}, ui_style(:button)    
  end

end
