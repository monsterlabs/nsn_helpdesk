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

#       div :class => 'field' do
#         label "Reported by"
#         rawtext f.select :reported_by_id, User.customers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  
#       end

#       div :class => 'field' do
#         label "Link"
#         rawtext f.collection_select :link_id, Link.all, :id, :sites, {:prompt => '-- Select --'}  
#       end

#       div :class => 'field' do
#         label "Frequency TX"
#         rawtext f.text_field :frequency_tx
#       end

#       div :class => 'field' do
#         label "Frequency RX"
#         rawtext f.text_field :frequency_rx
#       end

#       div :class => 'field' do
#         label "Product"
#         rawtext f.collection_select :product_id, Product.all, :id, :name, {:prompt => '-- Select --'}  
#       end

#       div :class => 'field' do
#         label "Priority reported by user"
#         rawtext f.collection_select :reported_priority_id, Priority.all, :id, :name, {:prompt => '-- Select --'}  
#       end

#       div :class => 'field' do
#         label "Failure description"
#         rawtext f.collection_select :failure_id, Failure.all, :id, :title, {:prompt => '-- Select --'}  
#       end

#       div :class => 'field' do
#         label "Alarm description"
#         rawtext f.text_field :alarm
#       end

#       div :class => 'field' do
#         label "Attended by"
#         rawtext f.select :attended_by_id, User.field_managers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  
#       end

#       div :class => 'field' do
#         label "Priority"
#         rawtext f.select :priority_id, Priority.all.collect { |record| [record.name, record.id ]}, {:prompt => '-- Select --'}  
#       end

#       h2 do
#         text 'Assign ticket to Field Manager'
#       end

#       div :class => 'assign_attributes' do
#         span :class => 'field_manager' do
#           label b "Field Manager:"
#           rawtext f.select :assigned_to_id, User.field_managers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}
#         end
        
#         span :class => 'ticket_type' do
#           label b "Ticket Type:"
#           rawtext f.select :ticket_type_id, TicketType.all.collect { |record| [record.name, record.id ]}, {:prompt => '-- Select --'}
#         end
#       end

#       h2 do
#         text 'Status'
#       end

#       div do
#         rawtext f.select :status_id, Status.all.collect { |record| [record.name, record.id]}, {:prompt => '-- Select --'}
#       end

#       h2 do
#         text 'User that accepts Ticket closing'
#       end

#       div do
#         rawtext f.select :reported_by_id, User.customers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  #add selected id
#       end

    end
  end
end
