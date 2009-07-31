class Views::Users::Show < Views::Layouts::Application
  needs :user

  def content
    h1 'Información del usuario '
    table :id => "profile-info" do
      tr do 
        td { b 'Login:' }
        td { rawtext @user.login}
      end

      tr do 
        td { b 'E-mail:' }
        td { rawtext @user.email}
      end
    end
  end
end
