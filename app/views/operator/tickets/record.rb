class Views::Operator::Tickets::Record < Erector::RailsWidget
  needs :collection

  def content
    @collection.each do |ticket|
      div :class => 'row_record' do
        div :class => 'cell_id' do
          rawtext ticket.id
        end
        div :class => 'cell_subject' do
          rawtext ticket.subject
        end
        div :class => 'cell_ticket_type' do
          rawtext ticket.ticket_type.name
        end
        div :class => 'cell_priority' do
          rawtext ticket.priority.name
        end
        div :class => 'cell_region' do
          rawtext ticket.region.name
        end
        div :class => 'cell_actions' do
          widget Views::Operator::Tickets::Actions, :ticket_id => ticket.id
        end
      end

    end
  end
end
