class Views::FieldManager::Tickets::Form < Erector::RailsWidget
  needs :f
  
  def content
    fieldset do

      div :class => 'field' do
        label "Reported by"
        rawtext f.select :reported_by_id, User.customers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Link"
        rawtext f.collection_select :link_id, Link.all, :id, :sites, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Frequency TX"
        rawtext f.text_field :frequency_tx
      end

      div :class => 'field' do
        label "Frequency RX"
        rawtext f.text_field :frequency_rx
      end

      div :class => 'field' do
        label "Product"
        rawtext f.collection_select :product_id, Product.all, :id, :name, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Priority reported by user"
        rawtext f.collection_select :reported_priority_id, Priority.all, :id, :name, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Failure description"
        rawtext f.collection_select :failure_id, Failure.all, :id, :title, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Alarm description"
        rawtext f.text_field :alarm
      end

      div :class => 'field' do
        label "Attended by"
        rawtext f.select :attended_by_id, User.field_managers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Priority"
        rawtext f.select :priority_id, Priority.all.collect { |record| [record.name, record.id ]}, {:prompt => '-- Select --'}  
      end

    end
  end
end
