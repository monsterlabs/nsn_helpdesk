class Views::Reports::DetailedCasesForm < Views::Layouts::Application

  def content
    # h2 "Detailed Cases"
    #  br
    #  br
    #  form_for(:report, :url => {:action => 'create'}) do
    #    div :class => "grid_5 prefix_1" do
    #      b "Case type" 
    #      br
    #      br
    #      check_box_tag 'report[priorities][]', '1'
    #      text 'Emergencies (High)'
    #      br
    #      check_box_tag 'report[priorities][]', '2'
    #      text 'Corrective manteinance (Medium)'
    #      br
    #      check_box_tag 'report[priorities][]', '3'
    #      text 'Corrective manteinance (Low)'
    #    end
    # 
    #    div :class => "grid_2", :style => 'margin-left: -25px;' do
    #      b "Regions" 
    #      br
    #      br
    #      rawtext select :report, :region_id, (options_for_select Region.all.collect {|record| [record.name, record.id]}), {}, {:multiple => true, :size => 9}
    #    end
    # 
    #    div :class => "grid_2" do
    #      b "Months" 
    #      br
    #      br
    #      rawtext select_month(Date.today, { :field_name => 'months', :prefix => 'report' }, { :multiple => true, :size => 9 }).sub(/months\]/, "months][]")
    #    end
    # 
    #    div :class => "grid_2" do
    #      b "Year" 
    #      br
    #      br
    #      rawtext select :report, :year, (2009..(Date.today.year + 5)).collect { |y| [y, y]}
    #    end
    # 
    #    div :class => 'clear'
    #    br
    #    rawtext submit_tag "Get report", ui_style(:button)
#    end
    h2 'Work in progress....'
  end

end