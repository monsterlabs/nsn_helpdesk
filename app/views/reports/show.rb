class Views::Reports::Show < Views::Layouts::Application

  js 'swfobject'
  
  def page_title
     "Reports show"
   end

   def view_content
      br
       div :class => "grid_16" do
            @graphs.each do |graph| 
               rawtext graph
               rawtext hr
            end
       end
       div :class => 'clear'
       rawtext link_to('Back', {:action => 'index'}, ui_style(:button))

   end

end