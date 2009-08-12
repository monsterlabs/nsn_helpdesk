class Views::Links::ShowRecord < Views::Layouts::Application
  needs :record

  def content
    rawtext hidden_field_tag 'ticket[link_id]', record.id
     p do
       b { text "City"}
       text record.city.name if record.city
     end
     p do
       b { text "Frequency Tx"}
       text record.frequency_tx
     end
     p do
       b { text "Frequency Rx"}
       text record.frequency_rx
     end
     p do
       b { text "Time zone"}
       text record.time_zone.name if record.time_zone
     end
     p do
       b { text "Status"}
       text record.current_status
     end
  end
end