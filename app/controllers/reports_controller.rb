class ReportsController < ApplicationController
  skip_before_filter :filter_access_filter
  skip_before_filter :require_user

  include MyGraph
  def index
    render 'reports/index'
  end

  def show_form
    respond_to do |format|
      format.html { render "reports/#{params[:form_name]}.rb" }
      format.js   { render "reports/#{params[:form_name]}_js.rb" }
    end
  end

  def cases_by_region_chart
    if !params[:report][:region_id].nil? and !params[:report][:priorities].nil? and !params[:report][:months].nil? and !params[:report][:year].nil?
      render 'reports/by_region_chart'
    else
      @errors = "You should select at least one element in each option"
      render 'reports/cases_by_region'
    end
   end  
  
  def by_region_chart
      @data = TicketReporter.find_by_region_and_reported_priority_per_month(params[:region_id], params[:priorities], params[:months], params[:year])
      @graph = method("#{params[:chart_type]}_chart").call(@data) 
      respond_to do |format|
        format.html { render :text => @graph.to_s }
        format.xls  { render :action => 'results', :layout => false}
      end
  end

  def cases_main_chart
    if !params[:report][:priorities].nil? and !params[:report][:months].nil? and !params[:report][:year].nil?
      render 'reports/main_chart'
    else
      @errors = "You should select at least one element in each option"
      render 'reports/all_cases'
    end
  end

  def main_chart
    @data = TicketReporter.find_by_reported_priority_per_month(params[:priorities], params[:months],  params[:year])
    @graph = method("#{params[:chart_type]}_chart").call(@data)
    respond_to do |format|
      format.html { render :text => @graph.to_s }
      format.xls  { render :action => 'results', :layout => false}
    end
  end

  def detailed_chart
    if !params[:report][:region_id].nil? and !params[:report][:priorities].nil? and !params[:report][:months].nil? and !params[:report][:year].nil?    
      render 'reports/detailed_chart'
    else
     @errors = "You should select at least one element in each option"
     render 'reports/detailed_cases'
    end
  end

  def detailed_cases_chart
    @data = TicketReporter.find_by_region_and_reported_priority_and_status_per_month(params[:region_id], params[:priority_id], params[:months],  params[:year])
    @graph = stacked_bar_chart(@data)
    respond_to do |format|
      format.html { render :text => @graph.to_s }
      format.xls  { render :action => 'results', :layout => false}
    end
  end
end