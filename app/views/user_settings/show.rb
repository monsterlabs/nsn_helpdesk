class Views::UserSettings::Show < Views::Layouts::Application
  
  def page_title
    "Show User"
  end
  
  def view_content
    
    div :class => 'alpha prefix_3 grid_1' do
      if @user.person.nil? 
          rawtext image_tag "/photos/thumb/missing.png"
      else
          rawtext image_tag @user.person.photo.url(:thumb)
      end
    end
    div :class => 'prefix_1 grid_5 suffix_2 omega' do
      table :id => "profile-info" do
             tr do 
                 td { b 'Login:' }
                 td { rawtext @user.login}
             end
      
             tr do 
                 td { b 'E-mail:' }
                 td { rawtext @user.email}
             end
      
             tr do 
                 td { b 'Firstname:' }
                 td { rawtext @user.person.firstname unless @user.person.nil? }
             end
      
             tr do 
                 td { b 'Lastname:' }
                 td { rawtext @user.person.lastname unless @user.person.nil? }
             end
      
             tr do 
                 td { b 'Company:' }
                 td { rawtext @user.person.company.name if !@user.person.nil? and !@user.person.company.nil? }
             end
      
             tr do 
                 td { b 'Region:' }
                 td { rawtext @user.person.region.name if !@user.person.nil? and !@user.person.region.nil? }
             end
             
          end
    end
    div :class => 'clear'
    
    div do
      rawtext link_to('Modify', {:action => 'edit', :id => @user.id}, ui_style(:button))
    end
  end
end