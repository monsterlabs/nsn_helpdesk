class TicketReporter
  
   class << self
     def find_by_region_and_reported_priority_per_month(region_id, priorities, months, year)
       max_size = 5
       graph_data = []
       collection = Ticket.search(:region_id_equals => region_id)
       priorities.each do |p_id|
          results = collection.find_all_by_reported_priority_id(p_id)
          graph_data << [priority_name(p_id), cases_per_month(results, months, year)]
          max_size = cases_per_month(results, months, year).max if cases_per_month(results, months, year).max > max_size
       end
       {:region_name => region_name(region_id), :graph_data => graph_data, :months => months, :max_size => max_size, :year => year}
     end
     
     private
     
     def priority_name(id)
        Priority.find(id).name
     end
     
     def region_name(id)
        Region.find(id).name
     end

     def cases_per_month(records, months, year)
       months.collect { |month| collection_per_month(records, month, year).compact.size }
     end
     
     def collection_per_month(records, month, year)
       records.collect { |record| record if record.updated_at.month == month.to_i and record.updated_at.year == year.to_i }
     end
  end


end
