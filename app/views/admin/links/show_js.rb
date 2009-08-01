class Views::Admin::Links::ShowJs < Views::Layouts::ApplicationJs
  def js_content
    p do
      b { text "City"}
      text @record.city.name
    end
    p do
      b { text "Frequency Tx"}
      text @record.frequency_tx
    end
    p do
      b { text "Frequency Rx"}
      text @record.frequency_rx
    end
  end
end