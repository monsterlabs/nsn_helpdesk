class Views::Admin::Users::New < Views::Layouts::Application
  def page_title
    "Add User"
  end
  
  def view_content
    rawtext error_messages_for 'user', :class => 'ui-state-error ui-corner-all'
    form_for(:user, @user, :url => { :action => "create"}, :html => { :multipart => true}) do |f|
      h2 do
        text 'Add user'
      end
      widget Views::Admin::Users::Form, :f => f, :user => @user
      
      rawtext f.submit 'Create', ui_style(:button)
    end
  end

end