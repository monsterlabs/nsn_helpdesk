class Views::Admin::Links::Show < Views::Layouts::Application

  def page_title
    "Show Link"
  end

  def view_content
    widget Views::Links::Show, :record => @record
    link_to "Modify", { :action => 'edit', :id => @record.id }, ui_style(:button)
    link_to "Cancel", { :action => 'index' }, ui_style(:button)
    4.times { br }
    widget Views::Shared::ShowLog, :record => @record
  end
end