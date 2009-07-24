class Views::FieldManager::Tickets::Form < Erector::RailsWidget
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
      div :id => 'details'
      div :class => 'field' do
          rawtext f.hidden_field :opened_at
      end
    end
  end
end
