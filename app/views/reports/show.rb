class Views::Reports::Show < Views::Layouts::Application

  js 'swfobject'
  
  def page_title
     "Reports show"
   end

   def view_content
      br
       div :class => "grid_16" do
         h = %Q( {"title":{"text":"Reports for Region 6"},"elements":[],"y_axis":{"steps":1,"max":5,"min":0},"bg_colour":"#ffffcc","x_axis":{"labels":{"labels":["Feb"]}}})
         
         rawtext @graph.sub(/link/, h)
       end
       div :class => 'clear'
       rawtext link_to('Back', {:action => 'index'}, ui_style(:button))

   end
end