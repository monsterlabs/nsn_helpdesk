class Views::Sessions::New < Views::Layouts::Application
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
      p { rawtext submit_tag "Sign In", ui_style(:button) }
    end
  end


end