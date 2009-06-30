class Views::UserSettings::Edit < Views::Layouts::Application
  def page_title
    "Edit User"
  end
  
  def view_content
    rawtext error_messages_for 'user'
    form_for(:user, :html => { :multipart => true}) do |f|
      widget Views::UserSettings::Form, :user => @user
      
      rawtext f.submit 'Update', as_button
    end
  end

end