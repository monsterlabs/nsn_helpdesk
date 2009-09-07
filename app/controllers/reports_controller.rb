class ReportsController < ApplicationController
  skip_before_filter :filter_access_filter
  skip_before_filter :require_user

  include MyGraph

  def index
    render 'reports/index'
  end

  def show_form
    respond_to do |format|
      format.js { render "reports/#{params[:form_name]}_js.rb" }
    end
  end

  def cases_by_region_chart
     regions = params[:report][:region_id]
     params[:report].delete(:region_id)
     @graphs = regions.collect { |region_id| open_flash_chart_object(800,280,by_region_chart_reports_url(params[:report].merge(:region_id => region_id))) }
     render 'reports/by_region_chart'
   end  
  
  def by_region_chart
    @data = TicketReporter.find_by_region_and_reported_priority_per_month(params[:region_id], params[:priorities], params[:months], params[:year])
    @graph = method("#{params[:chart_type]}_chart").call(@data)
    render :text => @graph.to_s
  end

  def cases_main_chart
    @graph = open_flash_chart_object(800,280,main_chart_reports_url(params[:report]))
    render 'reports/main_chart'
  end

  def main_chart
    @data = TicketReporter.find_by_reported_priority_per_month(params[:priorities], params[:months],  params[:year])
    @graph = method("#{params[:chart_type]}_chart").call(@data)
    render :text => @graph.to_s
  end

  def detailed_chart
    regions = params[:report][:region_id]
    params[:report].delete(:region_id)
    @graphs = regions.collect { |region_id| open_flash_chart_object(800,280,detailed_cases_chart_reports_url(params[:report].merge(:region_id => region_id))) }
    render 'reports/detailed_chart'
  end

  def detailed_cases_chart
    @data = TicketReporter.find_by_region_and_reported_priority_and_status_per_month(params[:region_id], params[:priorities], params[:months],  params[:year])
    @graph = stacked_bar_chart(@data)
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
      sheet[row,4] = ticket.reported_by.email
      sheet[row,5] = ticket.opened_at_local
      sheet[row,6] = ticket.case_id
      sheet[row,7] = !ticket.assigned_to.nil? ? ticket.assigned_to.person.fullname : ticket.link.region.users.field_managers.collect {|fm| fm.person.fullname }.join(', ')
      sheet[row,8] = !ticket.assigned_to.nil? ? ticket.assigned_to.id : ticket.link.region.users.field_managers.collect {|fm| fm.id }.join(', ')
      sheet[row,9] = ticket.created_at.to_s 
      sheet[row,10] = ticket.capture_time
      sheet[row,11] = ticket.product.name
      sheet[row,12] = ticket.link.region.name
      sheet[row,13] = ticket.failure.name
      sheet[row,14] = ticket.status.name
      sheet[row,15] = ticket.reported_priority.name 
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
      sheet[row,26] = ticket.notes
      unless ticket.assigned_to.nil?
        sheet[row,27] = ticket.accepts_closing.person.fullname
        sheet[row,28] = ticket.updated_at
        sheet[row,29] = ticket.ticket_type.name unless ticket.ticket_type.nil?
      end
    end
    book.write  RAILS_ROOT + '/public/report.xls'
    RAILS_ROOT + '/public/report.xls'
  end
end