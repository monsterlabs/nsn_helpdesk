class Views::Admin::Users::Edit < Views::Layouts::Application
  def page_title
    "Edit User"
  end
  
  def view_content
    rawtext error_messages_for 'user'
    form_for(:user, @user, :url => { :action => "update"}, :html => { :multipart => true}) do |f|
      h2 do
        text 'Edit user'
      end
      widget Views::Admin::Users::Form, :f => f, :user => @user
      
      rawtext f.submit 'Create'
    end
  end

end