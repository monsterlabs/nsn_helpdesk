class Views::Links::Show < Views::Layouts::Application
  needs :record

  def content
    table :id => "show" do
      [:sites, :frequency_tx, :frequency_rx, :current_status].each do |column|
        tr do 
          td { b column.to_s.capitalize }
           td { text @record.send(column) }
        end
      end
    end
    #widget Views::Shared::ShowLog, :record => @record
  end
end
