class Views::SuperScaffold::New < Views::Layouts::Application
  def page_title
    "Add #{@record.class}"
  end
  
  def view_content
    rawtext error_messages_for 'record', :class => 'ui-state-error ui-corner-all'
    form_for(@record.class.to_s.downcase.to_sym, @record, :url => {:action => 'create'} ) do |f|
      h2 do
        text "Add #{@record.class}"
      end
      widget Views::SuperScaffold::Form, :f => f, :record => @record, :columns => @columns
      
      rawtext f.submit 'Create', ui_style(:button)
    end
  end

end