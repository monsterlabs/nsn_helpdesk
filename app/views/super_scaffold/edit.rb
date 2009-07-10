class Views::SuperScaffold::Edit < Views::Layouts::Application
  def page_title
    "Edit User"
  end
  
  def view_content
    rawtext error_messages_for 'record', :class => 'ui-state-error ui-corner-all'
    form_for(@record, :url => {:action => 'update'}) do |f|
      h2 do
        text "Edit #{@record.class}"
      end
      widget Views::SuperScaffold::Form, :f => f, :record => @record, :columns => @columns
      
      rawtext f.submit 'Update', ui_style(:button)
      link_to  'Cancel', {:action => :index},  ui_style(:button)
    end
  end

end
