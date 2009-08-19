class Views::Reports::Index < Views::Layouts::Application

  js 'swfobject'

  def page_title
    "Reports Index"
  end

  def view_content
    rawtext error_messages_for 'report', :class => 'ui-state-error ui-corner-all'
    div :class => "grid_16" do
      span :class => 'clear'
      form_remote_tag(:url => "/reports/create") do 
        div :class => "grid_4 prefix_1" do
          b "Case type" 
          br
          br
          check_box_tag 'report[priority][]', '1'
          text 'Emergencies'
          br
          check_box_tag 'report[priority][]', '>1'
          text 'Corrective manteinance'
        end
        div :class => "grid_2", :style => 'margin-left: -30px;' do
          b "Status" 
          br
          Status.all.each do |status|
            br
            check_box_tag 'report[status][]', status.id
            text status.name
          end
        end

        div :class => "grid_2" do
          b "Regions" 
          br
          br
          rawtext select :report, :region_id, (options_for_select Region.all.collect {|record| [record.name, record.id]}), {}, {:multiple => true, :size => 5}
        end

        div :class => "grid_2" do
          b "Months" 
          br
          br
          rawtext select_month(Date.today, {:field_name => 'ticket[months]'}, {:multiple => true, :size => 5})
        end

        div :class => "grid_2" do
          b "Year" 
          br
          br
          rawtext select_year(Date.today, {:field_name => 'ticket[year]'})
        end

        span :class => 'clear'
        br
        div :class => "grid_4 prefix_1" do
          b "Report type"
          br
          br
          rawtext radio_button_tag 'graph[report_type]', 'total'
          text 'Total of cases'
          br
          rawtext radio_button_tag 'graph[report_type]', 'comparative'
          text 'Comparative'
        end
        div :class => "grid_2", :style => 'margin-left: -30px;' do
          b "Chart type"
          br
          br
          rawtext radio_button_tag 'graph[graph_type]', 'bar'
          text 'Bar'
          br
          rawtext radio_button_tag 'graph[graph_type]', 'pie'
          text 'Pie'
        end

      end
    end
  end
    
end
