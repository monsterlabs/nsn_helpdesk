class Views::Operator::Tickets::Form < Erector::RailsWidget
  needs :f
  
  def content
    fieldset do
      div :class => 'field' do
        label "Product"
        rawtext f.collection_select :product_id, Product.all, :id, :name, {:prompt => '-- Select --'}  
      end      
      div :class => 'field' do
        label "Region"
        rawtext filter_select(:region, :customer_filter)
      end
      # div :class => 'field' do
      #   label "Ticket type"
      #   rawtext f.collection_select :ticket_type_id, TicketType.all, :id, :name, {:prompt => '-- Select --'}  
      # end
      # div :class => 'field' do
      #   label "Priority"
      #   rawtext f.collection_select :priority_id, Priority.all, :id, :name, {:prompt => '-- Select --'}  
      # end
    end
  end
end
