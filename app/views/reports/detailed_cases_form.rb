class Views::Reports::DetailedCasesForm < Views::Layouts::Application

  def content
    h2 "Detailed Cases"
    br
    br
    form_for(:report, :url => {:action => 'detailed_chart'}, :html => { :id => :report_form }) do
      div :class => "grid_5 prefix_1" do
        b "Case type (" 
        link_to_function 'Check all / None', "toggle_checkbox('report_form', 'report_priorities_')"
        b ")"
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

      div :class => "grid_2", :style => 'margin-left: -25px;' do
        b "Regions" 
        br
        br
        rawtext select :report, :region_id, (options_for_select Region.all.collect {|record| [record.name, record.id]}), {}, {:multiple => true, :size => 9, :selected => Region.first.id}
      end

      div :class => "grid_2" do
        b "Months" 
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

      div :class => 'clear'
      br
      rawtext submit_tag "Get report", ui_style(:button)
    end
  end

end