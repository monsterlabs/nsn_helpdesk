class Views::Layouts::Application < Views::Layouts::Page

  css "grid", "application", "custom-theme/jquery-ui-1.7.2.custom"
  js  "application", "jquery", "jquery-ui", "jrails"
<<<<<<< HEAD:app/views/layouts/application.rb
  
  jquery <<-Str
      $('#feedback').click(function() {
        $('#feedback-dialog').dialog('open');
      });
      
      $("#feedback-dialog").dialog({
        bgiframe: true,
        height: 280,
        modal: true,
        autoOpen: false,
        draggable: false,
        resizable: false
      });
    Str
  
=======

  include DashboardHelper

>>>>>>> f2db12ce43717bb0b847b5a769ed1608b863b176:app/views/layouts/application.rb
  def body_content
    feedback
    div :class => "container_16" do
      ## Create the layout
      header_bar
      toplinks
      dashboard
      ## This is where the view sets its content
      div :class => "prefix_1 grid_14 suffix_1" do
        view_content
        dialog
      end
      div :class => "clear"
    end
    footer
  end

  def header_bar
    div :class => "grid_16", :id => "header"
    div :class => "clear" 
  end
  
  def toplinks
    div :class => "grid_16", :id => "toplinks" do
          text b(current_user.login)
          text ' | ' 
          link_to 'My account', user_settings_path
          text ' | ' 
          link_to 'Sign out', logout_url
    end
  end
  
  def dashboard
    div  :class => "grid_16", :id => 'dashboard' do
        text mydashboard
    end
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
<<<<<<< HEAD:app/views/layouts/application.rb
  
  def dialog
    div :id => "feedback-dialog", :title => "Send your feedback" do
      widget Views::Feedback::Form
    end
  end

=======
>>>>>>> f2db12ce43717bb0b847b5a769ed1608b863b176:app/views/layouts/application.rb
end
