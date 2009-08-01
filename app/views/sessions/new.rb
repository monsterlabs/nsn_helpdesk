class Views::Sessions::New < Views::Layouts::Application
  jquery <<-Str
      $('#forgot').click(function() {
        $('#forgot-dialog').dialog('open');
      });
      
      $("#forgot-dialog").dialog({
        bgiframe: true,
        height: 200,
        modal: true,
        autoOpen: false,
        draggable: false,
        resizable: false
      });
    Str
  
  def page_title
    "New Session"
  end

  # Changing the layout
  def body_content
    div :class => "container_16" do
      header_bar
      div :class => "grid_10 ui-corner-all", :id => "new_session_main" do
        
      end
      div :class => "grid_6 ui-corner-all", :id => "login_box" do
        div :class => "prefix_1 grid_4 suffix_1 alpha", :id => "login_form" do
          login_form
        end
      end
      div :class => "clear"
      div :id => "forgot-dialog", :title => "Recover your password" do
        widget Views::Sessions::RecoverPassword
      end
      footer
    end
  end

  def login_form
    form_for @session, :session, :url => session_path do |f|
      p {
        rawtext f.label "Login"
        br
        rawtext f.text_field :login
      }
      p {
        rawtext f.label "Password"
        br      
        rawtext f.password_field :password
      }
      p {
        rawtext submit_tag "Sign In", ui_style(:button, {:id => "login_button"})
        div :id => "forgot" do 
          text "Forgot your password?" 
        end
      }
      rawtext flash[:warning] || flash[:message]
    end
  end

end