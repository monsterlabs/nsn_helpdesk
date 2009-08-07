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
  end
  
end
