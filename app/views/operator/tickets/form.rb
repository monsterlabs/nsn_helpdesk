class Views::Operator::Tickets::Form < Erector::RailsWidget
  needs :f
  
 def content
   rawtext "ID: 1"
   text "Title:"
   rawtext f.text_field :subject
   text "Link:"
   rawtext f.select(:link_id, Site.all.collect {|p| [ p.name, p.id ] })
   text " - "
   rawtext f.select(:link_id, Site.all.collect {|p| [ p.name, p.id ] })
   text "Ticket_type:"
   rawtext f.select(:ticket_type_id, TicketType.all.collect {|p| [ p.name, p.id ] })
   text "Asigned to:"
   rawtext f.select(:assigned_to_id,  Person.find(:all, :conditions => ['job_title=?', 'Field Manager']).collect {|p| [ p.fullname, p.id ] })
   text "Customer-FIX IT-"
   
   text "Opened by:"
   rawtext f.select(:reported_by_id,  Person.all.collect {|p| [ p.fullname, p.id ] })
   text "Opened date:"
   rawtext f.text_field :created_at
   text "Priority:"
   rawtext f.select(:priority_id, Priority.all.collect {|p| [ p.name, p.id ] })
   text "Region"
   rawtext f.select(:region_id, Region.all.collect {|p| [ p.name, p.id ] })   
   text "Status"
   rawtext f.select(:status_id, Status.all.collect {|p| [ p.name, p.id ] })
   text "Due date"
   text "Resolved date"

 end

end
