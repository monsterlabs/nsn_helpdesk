class Views::FieldManager::Tickets::Form < Erector::RailsWidget
  needs :f
  
  def content
      fieldset do
        if f.object.new_record?
          div :class => "field" do
            label "Time"
            span :id => 'timer'        
          end
      end

      div :class => 'field' do
        label "Product"
        rawtext simple_select :ticket, :product
      end      
      div :class => 'field' do
        label "Region"
        rawtext filter_select :region, :customer_filter
      end
      div :id => 'details' do
        div :class => 'field' do
          div :id => "link_details", :class => "prefix_3 grid_4" do
            widget Views::Links::ShowRecordJs, :record => f.object.link
          end
        end
        div :id => "add_edit_dialog"
        
      end
      
      div :class => 'field' do
        rawtext f.hidden_field :opened_at
      end      
      
    end
  end
end
