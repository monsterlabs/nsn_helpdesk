class Views::UserSettings::Show < Views::Layouts::Application
  def page_title
    "Show User"
  end
  
  def view_content
    unless @user.person.nil?
      div do
        rawtext image_tag(@user.person.photo.url(:medium)) if @user.person.photo.size.to_i > 0
      end
      div do
        text "Name: #{@user.person.fullname}"
      end
      div do
        text "Username: #{@user.login}"
      end
  else
      div do
        b "Information empty"
      end
  end
    div do
      rawtext link_to('Modify', {:action => 'edit', :id => @user.id}, ui_style(:button))
    end
  end
end