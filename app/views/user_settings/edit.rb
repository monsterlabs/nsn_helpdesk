class Views::UserSettings::Edit < Views::Layouts::Application
  def page_title
    "Edit User"
  end
  
  def view_content
    rawtext error_messages_for 'user'
    form_for(:user, :html => { :multipart => true}) do |f|
      widget Views::UserSettings::Form, :f => f, :user => @user
      
      rawtext f.submit 'Actualizar'
    end
  end

end