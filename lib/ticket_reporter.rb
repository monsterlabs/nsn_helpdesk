class TicketReporter

  class << self
    def find_by_region_and_reported_priority_per_month(region_id, priorities, months, year)
      max_size = 5
      graph_data = []
      collection = Ticket.search(:region_id_equals => region_id)
      records = []
      priorities.each do |p_id|
        results = collection.find_all_by_reported_priority_id(p_id)
        records << records_per_month(results, months, year)
        results_per_month = cases_per_month(results, months, year)
        graph_data << [priority_name(p_id), results_per_month]
        max_size = results_per_month.max if results_per_month.max > max_size
      end
      {:title => "Tickets for region #{region_name(region_id)}", :results => graph_data, :months => months, :max_size => max_size, :year => year, :records => records.flatten}
    end

    def find_by_reported_priority_per_month(priorities, months, year)
      max_size = 5
      graph_data = []
      records = []
      priorities.each do |p_id|
        results = Ticket.find_all_by_reported_priority_id(p_id)
        records << records_per_month(results, months, year)
        results_per_month = cases_per_month(results, months, year)
        graph_data << [priority_name(p_id), results_per_month]
        max_size = results_per_month.max if results_per_month.max > max_size
      end
      {:title => "Cases at #{year}", :results => graph_data, :months => months, :max_size => max_size, :year => year, :records => records.flatten}
    end

    def find_by_region_and_reported_priority_and_status_per_month(region_id, priority_id, months, year)
       max_size = 5
       graph_data = []
       collection = Ticket.search(:region_id_equals => region_id)
       records = []
       results = collection.find_all_by_reported_priority_id(priority_id)
       results_per_month = cases_per_month_and_status(results, months, year)
       graph_data << [priority_name(priority_id)] + results_per_month
       records << records_per_month_and_status(results, months, year)
       max_size = results_per_month.first.max if results_per_month.first.max > max_size
       priority_name = Priority.find(priority_id).name  
       {:title => "Tickets for region #{region_name(region_id)} with priority #{priority_name}", :results => graph_data, :months => months, :max_size => max_size, :year => year, :records => records.flatten, :priority => priority_name }
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

    def records_per_month(records, months, year)
      months.collect { |month| collection_per_month(records, month, year) }.flatten
    end

    def collection_per_month(records, month, year)
      records.collect { |record| record if record.created_at.month == month.to_i and record.created_at.year == year.to_i }.compact
    end

    def collection_per_month_and_status(records, months, year)
      months.collect { |month|
        Status.all.collect do |status|
          [ status.name.downcase.to_sym, 
            records.collect { |record| record if record.created_at.month == month.to_i and record.created_at.year == year.to_i and record.status_id == status.id }.compact.size
            ]
        end
      }
    end

    def cases_per_month_and_status(records, months, year)
      [cases_per_month(records, months, year), collection_per_month_and_status(records, months, year)]
    end

    def records_per_month_and_status(records, months, year)
      months.collect { |month|
        Status.all.collect { |status|
          records.collect { |record| record if record.created_at.month == month.to_i and record.created_at.year == year.to_i and record.status_id == status.id }.compact
        }
      }.flatten
    end
    
  end
end
