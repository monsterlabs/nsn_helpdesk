class Views::UserSettings::Show < Views::Layouts::Application
  
  def page_title
    "User settings"
  end
  
  def view_content
    div :class => 'prefix_1 grid_5 suffix_2 omega' do
       widget Views::Users::ShowRecord, :user => @user
       widget Views::People::Show, :person => @user.person
       widget Views::Addresses::Show, :addr => @user.address
    end
    div :class => 'clear'
    div do
      rawtext link_to('Modify', {:action => 'edit', :id => @user.id}, ui_style(:button))
      rawtext link_to('Back', {:controller => current_user.roles.first.name + '/tickets', :action => 'index'}, ui_style(:button))
    end
  end
end
