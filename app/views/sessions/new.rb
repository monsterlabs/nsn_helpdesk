require "#{RAILS_ROOT}/app/views/layouts/form"

class Views::Sessions::New < Views::Layouts::Page
  def page_title
    "New Session"
  end

  def body_content
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