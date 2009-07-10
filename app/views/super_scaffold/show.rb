class Views::SuperScaffold::Show < Views::Layouts::Application

  def page_title
    "Show #{@record.class}"
  end
  
  def view_content
    table :id => "show" do
      @columns.keys.each do |column|
        tr do 
          td { b column.to_s.capitalize }
           td { text @record.send(column) }
        end
      end
    end
    rawtext link_to "Modify", { :action => 'edit', :id => @record.id }, ui_style(:button)
    rawtext link_to "Cancel", { :action => 'index' }, ui_style(:button)
  end
end