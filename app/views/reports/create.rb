class Views::Reports::Create < Views::Layouts::Application

  def page_title
     "Reports..."
   end

   def view_content
      br
       div :class => "grid_16" do
     
         @graphs.each do |graph| 
           rawtext %(<iframe width="800" scrolling="no" height="280" frameborder="0" name="news" style="overflow: hidden;" src="#{graph}">%)
            rawtext graph
           rawtext "</iframe>"
         end
       end
       div :class => 'clear'
       rawtext link_to('Back', {:action => 'index'}, ui_style(:button))

   end
end