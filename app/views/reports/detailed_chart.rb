include OpenFlashChart::Controller
class Views::Reports::DetailedChart < Views::Layouts::Application

  js 'swfobject'
  
  def page_title
     "Reports show"
   end

   def view_content
      br
      regions = params[:report][:region_id]
      priorities = params[:report][:priorities]
      params[:report].delete(:region_id)
      params[:report].delete(:priorities)
      regions.each do |region_id|  
        priorities.each do |priority_id|
          div :class => "grid_14", :style => 'margin-top: 45px;' do
            rawtext open_flash_chart_object(800,280,detailed_cases_chart_reports_url(params[:report].merge(:region_id => region_id, :priority_id => priority_id)))
            br
            link_to 'Excel', formatted_detailed_cases_chart_reports_url(:params => params[:report].merge(:region_id => region_id, :priority_id => priority_id), :format => 'xls'), 
            br
          end
          br :class => 'clear'
        end
      end
      br :class => 'clear'
      rawtext link_to('Back', {:action => 'show_form', :form_name => 'detailed_cases'}, ui_style(:button))
   end
end