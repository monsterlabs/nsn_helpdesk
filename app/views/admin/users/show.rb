class Views::Admin::Users::Show < Views::Layouts::Application
  def page_title
    "Show User"
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
      link_to 'Back', {:action => :index},  ui_style(:button)
    end
    4.times { br }
    if @user.person.respond_to? :versions and @user.person.versions.size > 1
      widget Views::Shared::ShowLog, :record => @user.person
    end
    if  @user.address.respond_to? :versions and @user.address.versions.size > 1
      widget Views::Shared::ShowLog, :record => @user.address
    end
  end
end
