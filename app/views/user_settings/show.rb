class Views::UserSettings::Show < Views::Layouts::Application
  def page_title
    "Show User"
  end
  
  def view_content
    table :id => "show" do
      tr do 
          td { b 'Photo' }
          td { rawtext image_tag @user.person.photo.url(:thumb) }
       end

       tr do 
           td { b 'Login' }
           td { rawtext @user.login}
       end

       tr do 
           td { b 'E-mail' }
           td { rawtext @user.email}
       end

       tr do 
           td { b 'Firstname' }
           td { rawtext @user.person.firstname }
       end

       tr do 
           td { b 'Lastname' }
           td { rawtext @user.person.lastname }
       end

       tr do 
           td { b 'Company' }
           td { rawtext @user.person.company.name unless @user.person.company.nil? }
       end

       tr do 
           td { b 'Region' }
           td { rawtext @user.person.region.name unless @user.person.region.nil? }
       end
       
    end
    div do
      rawtext link_to('Modify', {:action => 'edit', :id => @user.id}, ui_style(:button))
    end
  end
end