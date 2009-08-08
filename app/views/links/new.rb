class Views::Links::New < Views::Layouts::Application
  def page_title
    "Add Link"
  end
  
  def view_content
    rawtext error_messages_for 'link', :class => 'ui-state-error ui-corner-all'
    form_for(:link, @link, :url => {:action => 'create'} ) do |f|
      h2 do
        text "Add Link"
      end
      widget Views::Links::Form, :record => f.object
      rawtext f.submit 'Create', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)
    end
  end

end