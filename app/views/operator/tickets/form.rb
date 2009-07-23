class Views::Operator::Tickets::Form < Erector::RailsWidget
  needs :f
  
  def content
    fieldset do
      div :id => 'timer'
      div :class => 'field' do
        label "Product"
        rawtext simple_select :ticket, :product
      end      
      div :class => 'field' do
        label "Region"
        rawtext filter_select :region, :customer_filter
      end
      div :id => 'details'
      div :class => 'field' do
        rawtext f.hidden_field :opened_at
      end      
      
    end
  end
end
