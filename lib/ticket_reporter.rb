class TicketReporter

  class << self
    def find_by_region_and_reported_priority_per_month(region_id, priorities, months, year)
      max_size = 5
      graph_data = []
      collection = Ticket.search(:region_id_equals => region_id)
      records = []
      priorities.each do |p_id|
        results = collection.find_all_by_reported_priority_id(p_id)
        graph_data << [priority_name(p_id), cases_per_month(results, months, year)]
        records << results.flatten
        max_size = cases_per_month(results, months, year).max if cases_per_month(results, months, year).max > max_size
      end
      {:title => "Tickets for region #{region_name(region_id)}", :results => graph_data, :months => months, :max_size => max_size, :year => year, :records => records}
    end


    def find_by_reported_priority_per_month(priorities, months, year)
      max_size = 5
      graph_data = []
      records = []
      priorities.each do |p_id|
        results = Ticket.find_all_by_reported_priority_id(p_id)
        graph_data << [priority_name(p_id), cases_per_month(results, months, year)]
        records << results.flatten
        max_size = cases_per_month(results, months, year).max if cases_per_month(results, months, year).max > max_size
      end
      {:title => "Cases at #{year}", :results => graph_data, :months => months, :max_size => max_size, :year => year, :records => records.flatten}
    end

    def find_by_region_and_reported_priority_and_status_per_month(region_id, priorities, months, year)
       max_size = 5
       graph_data = []
       collection = Ticket.search(:region_id_equals => region_id)
       records = []
       priorities.each do |p_id|
         results = collection.find_all_by_reported_priority_id(p_id)
         graph_data << [priority_name(p_id)] + cases_per_month_and_status(results, months, year)
         records << results.flatten
         max_size = cases_per_month_and_status(results, months, year).first.max if cases_per_month_and_status(results, months, year).first.max > max_size
       end
       {:title => "Tickets for region #{region_name(region_id)}", :results => graph_data, :months => months, :max_size => max_size, :year => year, :records => records}
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

    def collection_per_month_and_status(records, months, year)
      months.collect { |month|
        Status.all.collect do |status|
          [ status.name.downcase.to_sym, 
            records.collect { |record| record if record.updated_at.month == month.to_i and record.updated_at.year == year.to_i and record.status_id == status.id }.compact.size
            ]
        end
      }
    end

    def cases_per_month_and_status(records, months, year)
      [cases_per_month(records, months, year), collection_per_month_and_status(records, months, year)]
    end
    
  end
end
