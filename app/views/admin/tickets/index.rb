class Views::Admin::Tickets::Index < Views::Layouts::Application

  def page_title
    "Tickets Index"
  end

  def view_content
    div do
      label "Search by key:"
      rawtext text_field_tag 'search', '', :size => 7, :maxlength => 8
      label "  List tickets by:"
      rawtext select 'filter', 'filter_id', Filter.all.collect {|p| [p.name, p.id]}, {:prompt => '-- Select --'}
      rawtext observe_field :filter_filter_id, :url => {:action => :filter_tickets, :id => "$('filter_filter_id').value".to_i}, :with => "'id='+$('filter_filter_id').value" #, :loading => "$('ticket_form').update(''); $('tickets_loader_indicator').show();", :complete => "$('tickets_loader_indicator').hide();"
#      image_tag('progress_bar.gif', :id => "tickets_loader_indicator", :style => 'display: none')
      span :id => 'filter_selected' do
      end
    end    

    span :id=>"ticket_records" do
      widget Views::Admin::Tickets::Record, :collection => @collection
      paginator @collection
    end
    rawtext link_to 'Add ticket', {:action => 'new'}, ui_style(:button)    
  end

end
