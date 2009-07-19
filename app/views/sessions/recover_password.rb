class Views::Sessions::RecoverPassword < Views::Layouts::Application
  def page_title
    "Recover Password"
  end

  # Changing the layout
  def body_content
    div :class => "container_16" do
      header_bar
      div :class => "prefix_4 grid_8 suffix_4" do
        form_for :user, :url => "/recover_password" do |f|
          p {
            rawtext f.label "email"
            br
            rawtext f.text_field :email
          }
          p { rawtext submit_tag "Recover", ui_style(:button) }
        end
      end
      div :class => "clear"
    end
  end

end