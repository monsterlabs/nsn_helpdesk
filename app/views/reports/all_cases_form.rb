class Views::Reports::AllCasesForm < Views::Layouts::Application
  def content
    h2 'All Cases'
    br
    br
    form_for(:report, :url => {:action => 'cases_main_chart'}) do
      div :class => "grid_5 " do
        b "Case type" 
        br
        br
        check_box_tag 'report[priorities][]', '1'
        text 'Emergencies (High)'
        br
        check_box_tag 'report[priorities][]', '2'
        text 'Corrective manteinance (Medium)'
        br
        check_box_tag 'report[priorities][]', '3'
        text 'Corrective manteinance (Low)'
      end

      div :class => "grid_2", :style => 'margin-left: -25px;'  do
        b "Months" 
        br
        br
        rawtext select_month(Date.today, { :field_name => 'months', :prefix => 'report' }, { :multiple => true, :size => 9 }).sub(/months\]/, "months][]")
      end


      div :class => "grid_2" do
        b "Year" 
        br
        br
        rawtext select :report, :year, (2009..(Date.today.year + 5)).collect { |y| [y, y]}
      end
      
      div :class => "grid_2"do
         b "Chart type"
         br
         br
         rawtext radio_button_tag 'report[chart_type]', 'bar3d'
         text 'Bar'
         br
         rawtext radio_button_tag 'report[chart_type]', 'pie'
         text 'Pie'
      end

      div :class => 'clear'
      br
      rawtext submit_tag "Get report", ui_style(:button)
    end
  end
end