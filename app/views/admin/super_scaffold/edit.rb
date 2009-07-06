class Views::Admin::SuperScaffold::Edit < Views::Layouts::Application
  def page_title
    "Edit User"
  end
  
  def view_content
    rawtext error_messages_for 'record', :class => 'ui-state-error ui-corner-all'
    form_for(@record, :url => {:action => 'update'}) do |f|
      h2 do
        text "Edit #{@record.class}"
      end
      widget Views::Admin::SuperScaffold::Form, :f => f, :record => @record
      
      rawtext f.submit 'Update', ui_style(:button)
    end
  end

end
