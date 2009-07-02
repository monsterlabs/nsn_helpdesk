class Views::Admin::Priorities::New < Views::Layouts::Application
  def page_title
    "Add Priority"
  end
  
  def view_content
    rawtext error_messages_for 'priority'
    form_for(:priority, @record, :url => {:action => 'create'} ) do |f|
      h2 do
        text 'Add priority'
      end
      widget Views::Admin::Priorities::Form, :f => f, :priority => @record
      
      rawtext f.submit 'Create', ui_style(:button)
    end
  end

end