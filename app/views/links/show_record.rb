class Views::Links::ShowRecord < Erector::RailsWidget
  needs :record

  def content
    rawtext hidden_field_tag 'ticket[link_id]', record.id
    tr :id => "ticket_title" do
      td {}
      td {b 'Current Link Data'}
    end
    tr do
      td:id => 'ticket_left_cell' do
        text "Link"
      end
      td :id => 'ticket_right_cell' do
        rawtext record.sites
      end
    end
    tr do
      td:id => 'ticket_left_cell' do
        text "Region"
      end
      td :id => 'ticket_right_cell' do
        rawtext record.region.name
      end
    end
    tr do
      td:id => 'ticket_left_cell' do
        text "City"
      end
      td :id => 'ticket_right_cell' do
        rawtext record.city.name
      end
    end
    tr do
      td:id => 'ticket_left_cell' do
        text "Frequency TX"
      end
      td :id => 'ticket_right_cell' do
        text record.frequency_rx
      end
    end
    tr do
      td:id => 'ticket_left_cell' do
        text "Frequency RX"
      end
      td :id => 'ticket_right_cell' do
        text record.frequency_rx
      end
    end
    tr do
      td:id => 'ticket_left_cell' do
        text "TimeZone"
      end
      td :id => 'ticket_right_cell' do
        text record.time_zone.name
      end
    end
    tr do
      td:id => 'ticket_left_cell' do
        text "Configuration"
      end
      td :id => 'ticket_right_cell' do
        text record.configuration
      end
    end
  end
end
