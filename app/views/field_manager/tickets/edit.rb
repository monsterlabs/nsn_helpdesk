class Views::FieldManager::Tickets::Edit < Views::Layouts::Application
  def page_title
    "Edit Ticket"
  end
  
  def view_content
    rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
    form_for(@ticket, :url => { :action => "update"}) do |f|
       h2 do
         text 'Case details'
      end
      div :class => 'field' do
          label "Product"
          rawtext simple_select :ticket, :product, :selected => f.object.product_id
      end      
      div :class => 'field' do
          label "Region"
          rawtext filter_select :region, :customer_filter, :selected => f.object.link
      end
      widget Views::FieldManager::Tickets::EditDetails, :ticket => f.object
      
      rawtext f.submit 'Update', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)      
     end
  end
end
