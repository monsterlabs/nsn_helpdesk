class Views::SuperScaffold::Form < Erector::RailsWidget
  needs :f, :record, :columns
  
  def content
    fieldset do
    columns.each do |key,value|
      div :class => 'field' do
        text label ActiveSupport::Inflector.humanize(key)
        case value
        when 'string'
          rawtext f.text_field key
        when 'text'
          rawtext f.text_area key
        when 'select'
          rawtext f.collection_select "#{key}_id", ActiveSupport::Inflector.classify(key).constantize.all, :id, :name
        end
      end
      end
    end

  end
  
end
