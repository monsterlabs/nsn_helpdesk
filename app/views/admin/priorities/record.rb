class Views::Admin::Priorities::Record < Erector::RailsWidget
  needs :collection

  def content
    table do
      table_header
      table_body
    end
  end
  
  def table_header
    thead do |variable|
      th { text "id" }
      th { text "name" }
    end
  end

  def table_body
    tbody do
      collection.each do |record|
        tr do
          td { text record.id }
          td { text record.name }
        end
      end
    end
  end

end