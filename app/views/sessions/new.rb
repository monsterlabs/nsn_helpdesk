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
      div :class => "grid_6 ui-corner-all", :id => "login_box" do
        div :class => "prefix_1 grid_4 suffix_1 alpha ui-corner-all", :id => "login_form" do
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

   # Overriding body tag
   def content
     controller_setup
     setup
     rawtext doctype
     html :xmlns => 'http://www.w3.org/1999/xhtml', 'xml:lang' => 'en', :lang => 'en' do
       head { head_content }
       body :id => "new_session_body" do
         body_content
       end
     end
   end

   def footer
    div :id => "footer" do
      p :class => "login_view" do 
         text "Copyright ©2009 Nokia Siemens Networks. All Rights reserved." 
         br
         br
         text "NSN Mexico Cellular Transmission." 
      end
      div :class => "browsers login_view", :id => 'text' do
        text 'This application runs on:'
        div :class => 'browser_link', :id => 'safari' do
          a :href => 'http://www.apple.com/safari/' do
            img :src => "/images/Safari.png"
          end
        end
        div :class => 'browser_link', :id => 'firefox' do
          a :href => 'http://www.mozilla.com/firefox/' do
            img :src => "/images/firefox.png"
          end
        end
        div :class => 'browser_link', :id => 'chrome' do
          a :href => 'http://www.google.com/chrome/' do
            img :src => "/images/google-chrome.png"
          end
        end
        #div :class => 'browser_link', :id => 'explorer' do
          #link_to 'explorer', 'http://www.microsoft.com/windows/internet-explorer/default.aspx'
        #end
      end
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
