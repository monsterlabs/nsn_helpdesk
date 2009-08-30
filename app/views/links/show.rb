class Views::Links::Show < Views::Layouts::Application

  def page_title
    "Show Link"
  end

  def view_content
    table :id => "listing" do
      widget Views::Links::ShowRecord, :record => @link
    end
    if @link.respond_to? :versions and @link.versions.size > 1
      widget Views::Shared::ShowLog, :record => @link
    end

    link_to "Modify", { :action => 'edit', :id => @link.id }, ui_style(:button)
    link_to "Back", { :action => 'index' }, ui_style(:button)
  end
end
