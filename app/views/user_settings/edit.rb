class Views::UserSettings::Edit < Views::Layouts::Application
  def page_title
    "Edit User"
  end
  
  def view_content
    rawtext error_messages_for 'user'
    form_for(@user, :url=> user_setting_path(:id=>@user), :method => :put, :html => { :multipart => true}) do |f|
      fieldset do
        widget Views::UserSettings::Form, :f => f, :record => @user
      end
      rawtext f.submit 'Update', ui_style(:button)
      
    end
  end

end