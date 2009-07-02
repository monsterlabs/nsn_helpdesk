class Views::Admin::Priorities::Record < Erector::RailsWidget
  needs :collection
  
  def content
    collection.each do |record|
      div :id => dom_id(record) do
        rawtext dom_id(record)
        span { b { text "name" } }
        span { text record.name  }
        # widget Views::Admin::Users::Actions, :record_id => record.id
      end
    end
  end
  
end