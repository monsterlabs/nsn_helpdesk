class Views::Sessions::New < Views::Layouts::Application
  def page_title
    "New Session"
  end

  # Changing the layout
  def body_content
    div :class => "container_16" do
      header_bar
      div :class => "prefix_1 grid_10" do
        text "Text Placeholder"
      end
      div :class => "grid_4 suffix_1" do
        login_form
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
      p { rawtext submit_tag "Sign In" }
    end
  end


end