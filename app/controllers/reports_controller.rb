require 'spreadsheet'
class ReportsController < ApplicationController
  skip_before_filter :filter_access_filter
  skip_before_filter :require_user
  include MyGraph
  def index
    render 'reports/index'
  end

  def create
    @graphs = []
    params[:report][:region_id].each do |region_id|
       link = "/reports/bar?region_id=#{region_id}"
       months = params[:report][:months].collect { |m| "months[]=#{m}" }.join('&')
       link << "&" + months unless months.empty?
       priorities = params[:report][:priorities].collect { |p| "priorities[]=#{p}" }.join('&')
       link << "&" + priorities unless priorities.empty?
       link << "&" + "year=#{params[:report][:year]}"
      @graphs << open_flash_chart_object(800,280,link)
    end
    render 'reports/show'       
  end


  def report_all
    link = "/reports/bar_all?"
    months = params[:report][:months].collect { |m| "months[]=#{m}" }.join('&')
    link << "&" + months unless months.empty?
    priorities = params[:report][:priorities].collect { |p| "priorities[]=#{p}" }.join('&')
    link << "&" + priorities unless priorities.empty?
    link << "&" + "year=#{params[:report][:year]}"
    @graph = open_flash_chart_object(800,280,link)
    render 'reports/report_all'       
  end
  
  def bar
    @data = TicketReporter.find_by_region_and_reported_priority_per_month(params[:region_id], params[:priorities], params[:months], 2009)
    @graph = bar3d_chart(@data)
    render :text => @graph.to_s
  end

  def bar_all
    @data = TicketReporter.find_by_reported_priority_per_month(params[:priorities], params[:months],  params[:year])
    @graph = bar3d_chart(@data)
    render :text => @graph.to_s
  end
    
  def ticket_by_region
    @data = TicketReporter.find_by_region_and_reported_priority_per_month(params[:report][:region_id], params[:report][:priorities], params[:report][:months], params[:report][:year])
    @collection = @data[:records]
    send_file(excel_file(@collection), :type => "application/vnd.ms-excel", :disposition => "inline")
  end

  def ticket_all
    @data = TicketReporter.find_by_reported_priority_per_month(params[:report][:priorities], params[:report][:months],  params[:report][:year])
    @collection = @data[:records]
    send_file(excel_file(@collection), :type => "application/vnd.ms-excel", :disposition => "inline")
  end


  private
  def excel_file(collection)
    Spreadsheet.client_encoding = 'UTF-8'

    book = Spreadsheet.open RAILS_ROOT + '/public/ticket_list_template.xls'
    sheet = book.worksheet 0
    row = 0

    collection.each do |ticket|
      row = row + 1
      sheet[row,0] = ticket.reported_by.person.fullname
      sheet[row,1] = ticket.reported_by.person.company.name
      sheet[row,2] = ticket.reported_by.address.business_phone
      sheet[row,3] = ticket.reported_by.address.mobile_phone
      sheet[row,4] = ticket.opened_at_local
      sheet[row,5] = ticket.reported_by.email
      sheet[row,6] = ticket.case_id
      sheet[row,7] = !ticket.assigned_to.nil? ? ticket.assigned_to.person.fullname : ticket.link.region.users.field_managers.collect {|fm| fm.person.fullname }.join(', ')
      sheet[row,8] = !ticket.assigned_to.nil? ? ticket.assigned_to.id : ticket.link.region.users.field_managers.collect {|fm| fm.id }.join(', ')
      sheet[row,9] = ticket.created_at.to_s + ' America/Mexico_City'
      sheet[row,10] = ticket.capture_time
      sheet[row,11] = ticket.product.name
      sheet[row,12] = ticket.link.region.name
      sheet[row,13] = ticket.failure.name
      sheet[row,14] = ticket.status.name
      sheet[row,15] = ticket.reported_priority.name + ' ' + ticket.link.configuration
      sheet[row,16] = ticket.link.sites
      sheet[row,17] = ticket.affected_sites
      sheet[row,18] = ticket.link.frequency_tx
      sheet[row,19] = ticket.link.frequency_rx
      sheet[row,20] = ticket.alarm
      sheet[row,21] = ticket.special_instructions
      sheet[row,22] = ticket.attended_by.person.fullname
      sheet[row,23] = ticket.priority.name
      sheet[row,24] = ticket.opened_by.person.nil? ? ticket.opened_by.email : ticket.opened_by.person.fullname
      sheet[row,25] = ticket.opened_at.to_s + ' America/Mexico_City'
      unless ticket.assigned_to.nil?
        sheet[row,26] = ticket.notes
        sheet[row,27] = ticket.accepts_closing.person.fullname
        sheet[row,28] = ticket.updated_at
        sheet[row,29] = ticket.ticket_type.name
      end
    end
    book.write  RAILS_ROOT + '/public/test2.xls'
    RAILS_ROOT + '/public/test2.xls'
  end
end