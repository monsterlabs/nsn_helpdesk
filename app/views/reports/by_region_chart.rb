include OpenFlashChart::Controller
class Views::Reports::ByRegionChart < Views::Layouts::Application

  js 'swfobject'

  def page_title
    "Reports show"
  end

  def view_content
    regions = params[:report][:region_id]
    params[:report].delete(:region_id)
    regions.each do |region_id| 
      div :class => "grid_14", :style => 'margin-top: 45px;' do
        rawtext open_flash_chart_object(800,280,by_region_chart_reports_url(params[:report].merge(:region_id => region_id)))
        br
        link_to 'Excel', formatted_by_region_chart_reports_url(:params => params[:report].merge(:region_id => region_id), :format => 'xls'), 
        br
      end
      br :class => 'clear'
    end
    br
    div :class => 'clear'
    rawtext link_to('Back', {:action => 'index'}, ui_style(:button))
  end
end