class Views::Links::Show < Views::Layouts::Application

  def page_title
    "Show Link"
  end

  def view_content
    widget Views::Links::ShowRecord, :record => @link
    link_to "Modify", { :action => 'edit', :id => @link.id }, ui_style(:button)
    link_to "Cancel", { :action => 'index' }, ui_style(:button)
    4.times { br }
    widget Views::Shared::ShowLog, :record => @link
  end
end