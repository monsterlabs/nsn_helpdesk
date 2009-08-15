class Views::Links::Form < Views::Layouts::Application
  needs :record

  def content
    rawtext hidden_field_tag(:id, record.id) 
    p do
      label "Sites"
      rawtext text_field_tag("link[sites]", record.sites, :size => 30)
    end

    if current_user.role_symbols.include? :field_manager or current_user.role_symbols.include? :admin
      p do
        label "Region"
        rawtext collection_select :link, :region_id, Region.all, :id, :name, :selected => record.region_id
      end
    end

    p do
      label "City"
      rawtext collection_select :link, :city_id, City.all, :id, :name, :selected => record.city_id
    end

    p do
      label "Frequency Tx"
      rawtext text_field_tag("link[frequency_tx]", record.frequency_tx, :size => 10)
    end

    p do
      label "Frequency Rx"
      rawtext text_field_tag("link[frequency_rx]", record.frequency_rx, :size => 10)
    end

    p do
      label "Time zone"
      rawtext collection_select :link, :time_zone_id, TimeZone.all, :id, :name, :selected => record.time_zone_id
    end

    p do
      label "Configuration"
      rawtext text_field_tag("link[configuration]", record.configuration)
    end
  end
end
