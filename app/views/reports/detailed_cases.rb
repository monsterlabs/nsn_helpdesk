class Views::Reports::DetailedCases < Views::Layouts::Application
  def page_title
    "Reports Index"
  end

  def view_content
    2.times { br }
    reports_nav_bar
    3.times { br }
    div :class => "grid_16", :id => 'report_form' do
      unless @errors.nil?
        div :class => 'grid_14 ui-state-error ui-corner-all' do
         br  
         rawtext @errors
         br  
         br  
        end
        br :class => 'clear'
        br
      end
       widget Views::Reports::DetailedCasesForm
    end
  end
  
  def reports_nav_bar
    div :class => "grid_8 prefix_4" do
      link_to_remote 'All Cases', :url => show_form_reports_url(:form_name => 'all_cases_form'), :method => :get, :update => { :success => :report_form }
      text ' | '
      link_to_remote 'Cases by Region', :url => show_form_reports_url(:form_name => 'cases_by_region_form'), :method => :get, :update => { :success => :report_form }
      text ' | '
      link_to_remote 'Detailed Cases by Region', :url => show_form_reports_url(:form_name => 'detailed_cases_form'), :method => :get, :update => { :success => :report_form }
    end
  end
end
