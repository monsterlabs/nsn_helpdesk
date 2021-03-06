class Views::Reports::AllCasesForm < Views::Layouts::Application
  def content
    h2 'All Cases'
    br
    br
    form_for(:report, :url => {:action => 'cases_main_chart'}, :html => {:id => :report_form}) do
      div :class => "grid_5 " do
        b "Case type: "
        link_to_function 'All, None', "toggle_checkbox('report_form', 'report_priorities_')"
        br
        br
        check_box_tag 'report[priorities][]', '1', true
                text 'Emergencies (High)'
                br
                check_box_tag 'report[priorities][]', '2', true
                text 'Corrective manteinance (Medium)'
                br
        check_box_tag 'report[priorities][]', '3', true
        text 'Corrective manteinance (Low)'
      end

      div :class => "grid_3", :style => 'margin-left: -25px;'  do
        b "Months: " 
        link_to_function 'All, ', "toggle_all_multiple_select('report_months')"
        link_to_function 'None', "toggle_none_multiple_select('report_months')"
        br
        br
        rawtext select_month(Date.today, { :field_name => 'months', :prefix => 'report' }, { :multiple => true, :size => 9, :selected => Date.today.month }).sub(/months\]/, "months][]")
      end


      div :class => "grid_2" do
        b "Year" 
        br
        br
        rawtext select :report, :year, (2009..(Date.today.year + 5)).collect { |y| [y, y]}, :selected => Date.today.year
      end
      
      div :class => "grid_2"do
         b "Chart type"
         br
         br
         rawtext radio_button_tag 'report[chart_type]', 'bar3d', true
         text 'Bar'
         br
         rawtext radio_button_tag 'report[chart_type]', 'pie', false
         text 'Pie'
      end

      div :class => 'clear'
      br
      rawtext submit_tag "Get report", ui_style(:button)
    end
  end
end