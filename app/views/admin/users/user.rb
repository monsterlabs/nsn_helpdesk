class Views::Admin::Users::User < Erector::RailsWidget
  needs :f
  
  def content
    div :class => 'field' do
      label "E-mail"
      rawtext f.text_field :email 
    end
    div :class => 'field' do
      label "Login"
      if current_user.login == 'admin'
        rawtext f.text_field :login
      else
        rawtext f.object.login
      end
    end
    div :class => 'field' do
      label "Password"
      rawtext f.password_field :password
    end
    div :class => 'field' do
      label "Password confirmation"
      rawtext f.password_field :password_confirmation
    end
  end
  
end