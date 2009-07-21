class Views::FieldManager::Tickets::Form < Erector::RailsWidget
  needs :f
  
  def content
    fieldset do
      div :class => 'field' do
        label "Subject"
        rawtext f.text_field :subject
      end

      div :class => 'field' do
        label "Message"
        rawtext f.text_area :body
      end

      div :class => 'field' do
        label "Reported by"
        rawtext f.select :reported_by_id, User.customers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Assigned to"
        rawtext f.select :assigned_to_id, User.field_managers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Status"
        rawtext f.collection_select :status_id, Status.all, :id, :name, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Product"
        rawtext f.collection_select :product_id, Product.all, :id, :name, {:prompt => '-- Select --'}  
      end
      
      div :class => 'field' do
        label "Region"
        rawtext f.collection_select :region_id, Region.all, :id, :name, {:prompt => '-- Select --'}  
      end
      div :class => 'field' do
        label "Link"
        rawtext f.collection_select :link_id, Site.all, :id, :name, {:prompt => '-- Select --'}  
      end
      
      div :class => 'field' do
        label "Ticket type"
        rawtext f.collection_select :ticket_type_id, TicketType.all, :id, :name, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Priority"
        rawtext f.collection_select :priority_id, Priority.all, :id, :name, {:prompt => '-- Select --'}  
      end
    end
  end
end
