class Views::Reports::DetailedCasesForm < Views::Layouts::Application

  def content
    h2 "Detailed Cases"
    br
    br
    form_for(:report, :url => {:action => 'detailed_chart'}, :html => { :id => :report_form }) do
      div :class => "grid_5" do
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

      div :class => "grid_3", :style => 'margin-left: -30px;' do
            b "Status: " 
            link_to_function 'All, ', "toggle_all_multiple_select('report_status_id')"
            link_to_function 'None', "toggle_none_multiple_select('report_status_id')"
            br
            br
            rawtext select :report, :status_id, (options_for_select Status.all.collect {|record| [record.name, record.id]}), {}, {:multiple => true, :size => 4, :selected => Region.first.id}
      end
      div :class => "grid_3", :style => 'margin-left: -30px;' do
        b "Regions: " 
        link_to_function 'All, ', "toggle_all_multiple_select('report_region_id')"
        link_to_function 'None', "toggle_none_multiple_select('report_region_id')"
        br
        br
        rawtext select :report, :region_id, (options_for_select Region.all.collect {|record| [record.name, record.id]}), {}, {:multiple => true, :size => 9, :selected => Region.first.id}
      end

      div :class => "grid_3", :style => 'margin-left: -30px;' do
        b "Months: " 
        link_to_function 'All, ', "toggle_all_multiple_select('report_months')"
        link_to_function 'None', "toggle_none_multiple_select('report_months')"
        br
        br
        rawtext select_month(Date.today, { :field_name => 'months', :prefix => 'report' }, { :multiple => true, :size => 9, :selected => Date.today.month }).sub(/months\]/, "months][]")
      end

      div :class => "grid_2", :style => 'margin-left: -30px;' do
        b "Year" 
        br
        br
        rawtext select :report, :year, (2009..(Date.today.year + 5)).collect { |y| [y, y]}, :selected => Date.today.year
      end

      div :class => 'clear'
      br
      rawtext submit_tag "Get report", ui_style(:button)
    end
  end

end