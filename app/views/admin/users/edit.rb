class Views::Admin::Users::Edit < Views::Layouts::Application
  def page_title
    "Edit User"
  end
  
  def view_content
    rawtext error_messages_for 'user', :class => 'ui-state-error ui-corner-all'
    form_for(@user, :url => admin_user_path(@user), :method => :put, :html => { :multipart => true}) do |f|
      h2 do
        text 'Edit user'
      end
      widget Views::Admin::Users::Form, :f => f, :user => @user
      
      rawtext f.submit 'Save', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)
    end
  end

end
