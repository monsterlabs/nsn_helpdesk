require 'vendor/plugins/open_flash_chart/lib/open_flash_chart'
module MyGraph
  include OpenFlashChart

  def bar3d_chart(data={})
    bars   = []
    colours = {:high => "#750091", :medium => "#f99027", :low => "#9088AA"}

    data[:results].each do |label, values|
      # 3d bar graph, could be any bar graph though
      bar = Bar3d.new
      bar.set_key(label, 10)
      bar.colour = colours[(label.downcase.to_sym)]
      bar.values = values
      bars << bar
    end
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
    pie.colours = ["#750091", "#f99027", "#9088AA"]
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

    bars   = []
    colours = { :high => "#750091", :medium => "#f99027", :low => "#9088AA" }
    status_colours = { :open => '#ff0000', :assigned => '#FFCC00', :resolved => '#0000FF', :closed => '#00CC00'}
    data[:results].each do |label, values, stacked_values|
      stacked_bar = BarStack.new(:barwidth => 0.3, :axis =>'left')
      values.each_index do |index|
        stacked_bar.append_stack(stacked_values[index].collect {|s| {:val => s.last, :colour => status_colours[s.first]} })
      end
      bars << stacked_bar
      # 3d bar graph, could be any bar graph though
      bar = Bar3d.new
      bar.set_key(label, 10)
      bar.colour = colours[(label.downcase.to_sym)]
      bar.values = values
      bars << bar
    end
    bars.first.keys =  status_colours.keys.collect {|k| { 'colour' => status_colours[k], 'text' => k.to_s.capitalize, 'font-size' => 10}} 

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
    bars.each do |b|
      graph.add_element(b)
    end
    graph
  end

  def month_list(mymonths)
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
    mymonths.collect {|m| months[(m.to_i - 1)] } 
  end

end 