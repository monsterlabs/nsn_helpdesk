class Views::Reports::Index < Views::Layouts::Application

  js 'swfobject'

  def page_title
    "Reports Index"
  end

  def view_content
    br
    rawtext error_messages_for 'report', :class => 'ui-state-error ui-corner-all'
     div :class => "grid_16" do
       span :class => 'clear'
       form_for(:report, :url => {:action => 'create'}) do
#       form_tag(:url => {:action => :create}) do 
         div :class => "grid_5 prefix_1" do
           b "Case type" 
           br
           br
           check_box_tag 'report[priorities][]', '1'
           text 'Emergencies'
           br
           check_box_tag 'report[priorities][]', '2'
           text 'Corrective manteinance (Medium)'
           br
           check_box_tag 'report[priorities][]', '3'
           text 'Corrective manteinance (High)'
           
         end
     
         div :class => "grid_2", :style => 'margin-left: -35px;' do
           b "Regions" 
           br
           br
           rawtext select :report, :region_id, (options_for_select Region.all.collect {|record| [record.name, record.id]}), {}, {:multiple => true, :size => 5}
         end
    
         div :class => "grid_2" do
           b "Months" 
           br
           br
           rawtext select (:report, :months, [ ['Jan', '1'], ['Feb', '2'], ['Mar', '3'], ['Apr', '4'], ['May', '5'], ['Jun', '6'],
                                               ['Jul', '7'], ['Aug', '8'], ['Sept', '9'], ['Oct', '10'], ['Nov', '11'], ['December', '12'] ],
                                            {}, {:multiple => true, :size => 5})
         end
    
         div :class => "grid_2" do
           b "Year" 
           br
           br
           rawtext select_year(Date.today, {:field_name => 'report[year]'})
         end
    
         # span :class => 'clear'
         # br
         # div :class => "grid_5" do
         #   b "Report type"
         #   br
         #   br
         #   rawtext radio_button_tag 'graph[report_type]', 'total'
         #   text 'Total of cases'
         #   br
         #   rawtext radio_button_tag 'graph[report_type]', 'comparative'
         #   text 'Comparative'
         # end
         div :class => "grid_2", :style => 'margin-left: -35px;' do
           b "Chart type"
           br
           br
           rawtext radio_button_tag 'graph[graph_type]', 'bar'
           text 'Bar'
           br
           rawtext radio_button_tag 'graph[graph_type]', 'pie'
           text 'Pie'
         end
         div :class => 'clear'
         br
         rawtext submit_tag "Get report", ui_style(:button)
       end

     end
  end
    
end
