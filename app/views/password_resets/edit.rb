class Views::PasswordResets::Edit < Views::Layouts::Application

  def page_title
    "Reset my password"
  end

  def view_content
    widget Views::PasswordResets::Form
  end

end
