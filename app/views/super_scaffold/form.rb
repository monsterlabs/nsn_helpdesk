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
          rawtext f.collection_select "#{key}", ActiveSupport::Inflector.classify(key.to_s.sub(/\_id$/,'')).constantize.all, :id, :name
        end
      end
      end
    end

  end
  
end
