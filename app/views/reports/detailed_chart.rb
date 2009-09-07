class Views::Reports::DetailedChart < Views::Layouts::Application

  js 'swfobject'
  
  def page_title
     "Reports show"
   end

   def view_content
      br
       div :class => "grid_14" do
            @graphs.each do |graph| 
               rawtext graph
               br
               # link_to('Excel file', params.merge(:action => :ticket_by_region))
               br
            end
       end
       div :class => 'clear'
       rawtext link_to('Back', {:action => 'index'}, ui_style(:button))
   end

end