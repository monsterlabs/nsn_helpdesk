class Views::Admin::Tickets::Form < Erector::RailsWidget
  needs :f
  
  def content
    fieldset do
      div :class => 'field' do
        label "Subject"
        rawtext f.text_field :failure
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
        label "Product"
        rawtext f.collection_select :product_id, Product.all, :id, :name, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Frequency TX"
        rawtext f.text_field :frequency_tx, :size => 5
      end

      div :class => 'field' do
        label "Frequency RX"
        rawtext f.text_field :frequency_rx, :size => 5
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
      
#       f.fields_for 'priority_attributes' do |p|
#         div :class => 'field' do
#           label "Alarm type"
#           rawtext  p.collection_select :alarm_type_id, AlarmType.all, :id, :name, {:prompt => '-- Select --'}  
#         end
#       end

      div :class => 'field' do
        label "Call phone attended by"
        rawtext f.select :attended_by_id, User.field_managers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}  
      end

      div :class => 'field' do
        label "Due Date"
        rawtext date_select('date', 'data', :order => [:day, :month, :year], :start_year => Date.today.year)
      end

    end
  end
end
