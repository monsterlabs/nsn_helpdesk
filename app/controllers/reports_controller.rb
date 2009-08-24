class ReportsController < ApplicationController
  skip_before_filter :filter_access_filter
    skip_before_filter :require_user
  include MyGraph
  def index
    render 'reports/index'
  end

  def create
    @graphs = []
    counter = 1
    params[:report][:region_id].each do |region_id|
       link = "/reports/bar?region_id=#{region_id}"
       months = params[:report][:months].collect { |m| "months[]=#{m}" }.join('&')
       link << "&" + months unless months.empty?
       priorities = params[:report][:priorities].collect { |p| "priorities[]=#{p}" }.join('&')
       link << "&" + priorities unless priorities.empty?
       link << "&" + "year=#{params[:report][:year]}"
      @graphs << open_flash_chart_object(800,280,link)
      counter += 1
    end
    render 'reports/show'       
  end
  
  def bar
    @data = TicketReporter.find_by_region_and_reported_priority_per_month(params[:region_id], params[:priorities], params[:months], 2009)
    @graph = bar3d_chart(@data)
    render :text => @graph.to_s
  end
  
  def show_excel
    @data = TicketReporter.find_by_region_and_reported_priority_per_month(params[:region_id], params[:priorities], params[:months], 2009)
#    @file = Excel.new()
    render :text => :excel
  end


end