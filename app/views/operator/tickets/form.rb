class Views::Operator::Tickets::Form < Erector::RailsWidget
  needs :f
  
 def content
   div do
     rawtext "ID: #{Ticket.last.id}"
   end
   div do
     text "Title:"
     rawtext f.text_field :subject
   end
   text "Link:"
   rawtext f.select(:link_id, Site.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')
   text " - "
   rawtext f.select(:link_id, Site.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')
   text "Ticket_type:"
   rawtext f.select(:ticket_type_id, TicketType.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')
   text "Priority"
   rawtext f.select(:priority_id, Priority.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')
   text "Region"
   rawtext f.select(:region_id, Region.all.collect {|p| [ p.name, p.id ] }, :prompt => '-- Select --')   
 end
end
