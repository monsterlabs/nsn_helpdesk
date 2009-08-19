class ReportsController < ApplicationController
  skip_before_filter :filter_access_filter

  def index
    render 'reports/index'
  end

  def create
    link = "/reports/bar?region_id=#{params[:report][:region_id]}"
    months = params[:report][:months].collect { |m| "months[]=#{m}" }.join('&')
    link << "&" + months unless months.empty?
    priorities = params[:report][:priorities].collect { |p| "priorities[]=#{p}" }.join('&')
    link << "&" + priorities unless priorities.empty?
    @graph = open_flash_chart_object(800,280,link)
    render 'reports/show'

  end

  def bar
    params[:region_id] = params['region_id'] 
    #params[:priorities] = [1,2,3]
#    params[:months] = [7,8,9]

     bars   = []
     # random colors to chose from
     colours = ["#459a89", "#9a89f9","#330066" ]

     # the results
     results = Ticket.search(:region_id_equals => params[:region_id], :reported_priority_id_equals_any => params[:priorities]).group_by(&:reported_priority_id)

     # group by subject and use subject as the key
     max_size = 5
     results.each do |priority_id, result|
       # 3d bar graph, could be any bar graph though
       bar = Bar3d.new
       bar.set_key(Priority.find(priority_id).name, 10)
       bar.colour = colours[bars.size]
       v = []
       params[:months].each do |month|
         counter = 0
         result.each do |record|
          counter += 1 if record.updated_at.month == month.to_i
         end
         max_size = counter if counter > max_size
         v << counter
       end
       bar.values = v
       bars << bar
     end

     # some title
     title = Title.new("Reports for #{Region.find(params[:region_id]).name}")

     # labels along the x axis, just hard code for now, but you would want to dynamically do this
     x_axis = XAxis.new
     months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
     x_axis.labels = params[:months].collect {|m| months[(m.to_i - 1)] } 

     # go to 100% since we are dealing with test results
     y_axis = YAxis.new
     y_axis.set_range(0, max_size, 1)

     # setup the graph
     graph = OpenFlashChart.new
     graph.bg_colour = '#ffffcc'
     graph.title = title
     graph.x_axis = x_axis
     graph.y_axis = y_axis
     graph.elements = bars

     render :text => graph.to_s
  
  end

end