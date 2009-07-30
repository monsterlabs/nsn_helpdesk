class Views::FieldManager::Links::Show < Views::Layouts::Application

  def page_title
    "Show #{@record.class}"
  end
  
  def view_content
    table :id => "show" do
      [:sites, :frequency_tx, :frequency_rx, :current_status].each do |column|
        tr do 
          td { b column.to_s.capitalize }
           td { text @record.send(column) }
        end
      end
    end
    rawtext link_to "Modify", { :action => 'edit', :id => @record.id }, ui_style(:button)
    rawtext link_to "Cancel", { :action => 'index' }, ui_style(:button)

    br
    br
    br
    h2 'Changelog'

       table :id => "header" do
         tr do 
           td { label h3 "This link has #{@record.versions.size} version(s)."}
         end
       end
       
       @record.versions.reverse.each do |version|
         table :id => "versions" do
           tr do
             td {label "Version #{version.index + 1}:"}
           end
            tr do
              td {label "Created by:"}
              td {rawtext Person.find_by_user_id(version.whodunnit).fullname unless Person.find_by_user_id(version.whodunnit).nil?}
            end
         unless version.object.nil?
            tr do
              td {label "IP Address:"}
              td {rawtext version.object.split(/\n/).map {|part| part.split[1] if part.match(/ip_address/)}}
            end
         end
            tr do
              td {label "Event"}
              td {rawtext version.event}
            end
            tr do
              td {label "Created at"}
              td {rawtext version.created_at :short}
            end
       end
     end

  end
end
