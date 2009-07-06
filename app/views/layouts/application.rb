class Views::Layouts::Application < Views::Layouts::Page
  
  css "grid", "application", "custom-theme/jquery-ui-1.7.2.custom"
  js  "application", "jquery", "jquery-ui", "jrails"
  
  def body_content
    feedback
    div :class => "container_16" do
      ## Create the layout
      header_bar
      dashboard
      ## This is where the view sets its content
      div :class => "prefix_1 grid_14 suffix_1" do
        view_content
      end
      div :class => "clear"
    end
    footer
  end
  
  def header_bar
    div :class => "grid_16", :id => "header"
    div :class => "clear" 
  end
  
  def dashboard
    div :class => "grid_16", :id => "dashboard"
    div :class => "clear" 
  end
  
  def footer
    div :id => "footer" do
      p do
        text "Copyright © 2009"
      end
    end
  end

  def feedback
    div :id => "feedback"
  end

end
