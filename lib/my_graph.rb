require 'vendor/plugins/open_flash_chart/lib/open_flash_chart'
module MyGraph
  include OpenFlashChart
  
  def bar3d_chart(data={})
    bars   = []
    # random colors to chose from
    colours = ["#459a89", "#9a89f9","#330066" ]

    data[:results].each do |label, values|
      # 3d bar graph, could be any bar graph though
      bar = Bar3d.new
      bar.set_key(label, 10)
      bar.colour = colours[bars.size]
      bar.values = values
      bars << bar
    end

    # some title
    title = Title.new("#{data[:title]}")

    # labels along the x axis, just hard code for now, but you would want to dynamically do this
    x_axis = XAxis.new
    x_axis.labels = month_list(data[:months])

    # go to 100% since we are dealing with test results
    y_axis = YAxis.new
    interval = data[:max_size] > 10 ? (data[:max_size] / 5) : 1
    y_axis.set_range(0, data[:max_size], interval)

    # setup the graph
    graph = OpenFlashChart.new
    graph.bg_colour = '#ffffcc'
    graph.title = title
    graph.x_axis = x_axis
    graph.y_axis = y_axis
    graph.elements = bars
    graph
  end

  def pie_chart(data)
    title = Title.new("#{data[:title]}: #{month_list(data[:months]).join(', ')}")
    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent# of 100%'
    pie.colours = ["#330066", "#9a89f9", "#459a89" ]
    myvalues = []
    data[:results].each do |label, values|
      total = values.compact.inject(0) { |sum,item| sum + item }
      myvalues << PieValue.new(total, "#{label} (#{total})")
    end
    pie.values  = myvalues

    chart = OpenFlashChart.new
    chart.bg_colour = '#ffffcc'
    chart.title = title
    chart.add_element(pie)

    chart.x_axis = nil
    chart.render
  end

  def stacked_bar_chart(data={})
    title = Title.new(:text => "Stuff I'm thinking about", :style => "{font-size: 20px; color: #F24062; text-align: center;}")

    bar_stack = BarStack.new(:colours => ['#C4D318', '#50284A', '#7D7B6A'])
    bar_stack.append_stack([2.5,5,2.5])
    bar_stack.append_stack [2.5,5,1.25,1.25]
    bar_stack.append_stack [5, { "val" => 5, "colour" => "#ff0000" }]
    bar_stack.append_stack [2,2,2,2, { "val" => 2, "colour" => "#ff00ff" }]

    bar_stack.keys = [
      { "colour" => "#C4D318", "text" => "Kiting", "font-size" => 13 },
      { "colour" => "#50284A", "text" => "Work", "font-size" => 13 },
      { "colour" => "#7D7B6A", "text" => "Drinking", "font-size" => 13 },
      { "colour" => "#ff0000", "text" => "XXX", "font-size" => 13 },
      { "colour" => "#ff00ff", "text" => "What rhymes with purple? Nurple?", "font-size" => 13 }]
      bar_stack.tip = "X label [#x_label#], Value [#val#]<br>Total [#total#]"

      y = YAxis.new(:min => 0, :max => 14, :steps => 2)
      x = XAxis.new(:labels => {:labels => ["Winter", "Spring", "Summer", "Autumn"]})


      tooltip = Tooltip.new
      tooltip.mouse = 2

      chart = OpenFlashChart.new(:title => title)
      chart.add_element bar_stack
      chart.x_axis = x
      chart.y_axis = y
      chart.tooltip = tooltip
      chart.render
  end

  def month_list(mymonths)
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
    mymonths.collect {|m| months[(m.to_i - 1)] } 
  end
  
end