class Views::UserSettings::Show < Views::Layouts::Application
  def page_title
    "Show User"
  end
  
  def view_content
    div do
      rawtext image_tag(@user.person.photo.url(:medium))
    end
    div do
      text "Name: #{@user.person.fullname}"
    end
    div do
      text "Username: #{@user.login}"
    end
    div do
      rawtext link_to('Modify', {:action => 'edit', :id => @user.id}, as_button)
    end
  end
end