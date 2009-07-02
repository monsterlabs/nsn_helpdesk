class Views::Layouts::Application < Views::Layouts::Page
  
  css "grid", "application", "custom-theme/jquery-ui-1.7.2.custom"
  js  "application", "jquery", "jquery-ui", "jrails"
  
  def body_content
    div :class => "container_16" do
      ## Create the layout
      header_bar
      dashboard
      ## This is where the view sets its content
      div :class => "prefix_1 grid_14 suffix_1" do
        view_content
      end
    end
  end
  
  def header_bar
    div :class => "grid_16", :id => "header" do
      text "HEADER"
    end
    
    div :class => "clear" 
  end
  
  def dashboard
    div :class => "grid_16" do
      text "Dashboard"
    end
    
    div :class => "clear" 
  end

end
