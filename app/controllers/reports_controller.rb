class ReportsController < ApplicationController
  skip_before_filter :filter_access_filter

  def index
    @graph = open_flash_chart_object(800,280,"/reports/graph_bar")
  end
  def graph_bar
     bars   = []

     # random colors to chose from
     colours = ["#459a89", "#9a89f9","#330066" ]

     # the results
     results = Ticket.find(:all)

     # group by subject and use subject as the key
     max_size = 5
     results.group_by(&:reported_priority_id).each do |priority_id, result|
       # 3d bar graph, could be any bar graph though
       bar = Bar3d.new
       bar.set_key(Priority.find(priority_id).name, 10)
       bar.colour = colours[bars.size]
       v = []
       (1..12).each do |month|
         counter = 0
         result.each do |record|
          counter += 1 if record.updated_at.month == month
         end
         max_size = counter if counter > max_size
         v << counter
       end
       bar.values = v
       bars << bar
     end

     # some title
     title = Title.new("Region 1")

     # labels along the x axis, just hard code for now, but you would want to dynamically do this
     x_axis = XAxis.new
     x_axis.labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]

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