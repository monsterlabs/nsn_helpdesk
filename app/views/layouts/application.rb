class Views::Layouts::Application < Views::Layouts::Page

  css "reset", "grid", "application", "custom-theme/jquery-ui-1.7.2.custom", "jquery.autocomplete"
  js  "jquery.min", "jquery-ui", "jrails", "jquery.bgiframe.min", "jquery.ajaxQueue", "jquery.epiclock.min", "jquery.autocomplete.min", "jquery.badBrowser.js", "application"
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
      controller_title
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
          link_to 'Change my password', edit_change_password_url
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
      p {
         text "Copyright ©2009 Nokia Siemens Networks. All Rights reserved."
         br
         br
         text "NSN Mexico Cellular Transmission." 
        }
    end
  end

  def who_has_changed_it(user_id)
    @user = User.find(user_id)
    unless @user.nil?
      fullname =  @user.person.nil? ? 'admin' : @user.person.fullname
      "#{fullname} <#{@user.email}>"
    end
  end
  
  def controller_title
    div :class => 'grid_3 prefix_7', :id => 'controller_title' do
      h1 controller_name.capitalize
    end
  end  
end
