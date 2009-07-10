class Views::Operator::Tickets::Form < Erector::RailsWidget
  needs :f
  
  def content
    div :class => 'ticket_container' do
      div :class => 'row_id' do
        rawtext "ID: #{Ticket.last.id}"
      end
      div :class => 'row_subject' do
        text "Subject:"
        rawtext f.text_field :subject
      end
      div :class => 'row_region' do
        text "Region"
        rawtext f.select(:region_id, Region.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')   
      end
      div do
      text "Link:"
      rawtext f.select(:link_id, Site.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')
      text " - "
      rawtext f.select(:link_id, Site.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')
      end
      rawtext f.select(:ticket_type_id, TicketType.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')
      text "Priority"
      rawtext f.select(:priority_id, Priority.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')
    end
  end
end
