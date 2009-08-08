class Views::Links::Edit < Views::Layouts::Application
  def page_title
    "Edit Link"
  end
  
  def view_content
    rawtext error_messages_for 'link', :class => 'ui-state-error ui-corner-all'
    form_for(@link, :url => {:action => 'update', :id => @link.id}) do |f|
      h2 do
        text "Edit Link"
      end
      widget Views::Links::Form, :record => f.object
      rawtext f.submit 'Update', ui_style(:button)
      link_to  'Cancel', { :action => :index },  ui_style(:button)
    end
  end

end
