include OpenFlashChart::Controller
class Views::Reports::MainChart < Views::Layouts::Application

  js 'swfobject'

  def page_title
    "Reports show"
  end

  def view_content
    br
    div :class => "grid_14" do
      rawtext open_flash_chart_object(800,280,main_chart_reports_url(params[:report]))
      br
      link_to 'Excel', formatted_main_chart_reports_url(:params => params[:report], :format => 'xls')
    end
    br
    br :class => 'clear'
    rawtext link_to('Back', {:action => 'show_form', :form_name => 'all_cases'}, ui_style(:button))

  end

end