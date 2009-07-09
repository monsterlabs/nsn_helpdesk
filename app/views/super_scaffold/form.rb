class Views::SuperScaffold::Form < Erector::RailsWidget
  needs :f, :record, :columns
  
  def content
    puts columns.inspect
    div do
      columns.each do |key,value|
        text label key
        br
        case value
        when 'string'
          rawtext f.text_field key
        end
      end
    end
  end
  
end
