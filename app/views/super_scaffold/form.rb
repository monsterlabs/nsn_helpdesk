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
          rawtext f.option_groups_from_collection_for_select key, ActiveSupport::Inflector.humanize(key).constantize.all, :id, :name
        end
      end
      end
    end

  end
  
end
