class Views::SuperScaffold::Form < Erector::RailsWidget
  needs :f, :record, :columns
  
  def content
    fieldset do
    columns.each do |key,value|
      div :class => 'field' do
        text label key.to_s.capitalize
        case value
        when 'string'
          rawtext f.text_field key
        when 'text'
          rawtext f.text_area key
        end
      end
      end
    end

  end
  
end
