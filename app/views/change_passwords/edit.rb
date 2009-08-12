class Views::ChangePasswords::Edit < Views::Layouts::Application

  def page_title
    "Change my password"
  end

  def view_content
    rawtext flash[:notice]
    widget Views::ChangePasswords::Form
  end

end
