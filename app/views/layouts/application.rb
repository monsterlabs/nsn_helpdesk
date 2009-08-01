class Views::Layouts::Application < Views::Layouts::Page

  css "reset", "grid", "application", "custom-theme/jquery-ui-1.7.2.custom", "jquery.autocomplete"
  js  "jquery.min", "jquery-ui", "jrails", "jquery.bgiframe.min", "jquery.ajaxQueue", "jquery.epiclock.min", "jquery.autocomplete.min", "application"
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

  include DashboardHelper
  
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
      footer
    end
  end

  def header_bar
    div :class => "grid_16 clearfix", :id => "header"
  end
  
  def toplinks
    div :class => "grid_16", :id => "toplinks" do
          text b(current_user.login)
          text ' | ' 
          link_to 'My account', user_setting_path
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

  def feedback
    div :id => "feedback"
  end

  def dialog
    div :id => "feedback-dialog", :title => "Send your feedback" do
      widget Views::Feedback::Form
    end
  end
  
  def footer
    div :id => "footer" do
      p { text "Copyright ©2009 Nokia Siemens Networks. All Rights reserved." }
      div :class => "browsers", :id => 'text' do
        text 'This application runs on:'
        div :class => 'browser_link', :id => 'safari' do
          link_to 'safari', 'http://www.apple.com/safari/'
        end
        div :class => 'browser_link', :id => 'firefox' do
          link_to 'firefox', 'http://www.mozilla.com/firefox/'
        end
        div :class => 'browser_link', :id => 'chrome' do
          link_to 'chrome', 'http://www.google.com/chrome/'
          end
        end
        # link_to 'safari', 'http://www.apple.com/safari/', {:class => "browser_link", :id => "safari"}
        # link_to 'firefox', 'http://www.mozilla.com/firefox/', {:class => "browser_link", :id => "firefox"}
        # link_to 'chrome', 'http://www.google.com/chrome/', {:class => "browser_link", :id => "chrome"}
    end
  end
end
