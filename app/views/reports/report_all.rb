class Views::Reports::ReportAll < Views::Layouts::Application

  js 'swfobject'
  
  def page_title
     "Reports show"
   end

   def view_content
      br
       div :class => "grid_14" do
               rawtext @graph
               br
               link_to('Excel file', params.merge(:action => :ticket_all))
       end
       div :class => 'clear'
       rawtext link_to('Back', {:action => 'index'}, ui_style(:button))

   end

end