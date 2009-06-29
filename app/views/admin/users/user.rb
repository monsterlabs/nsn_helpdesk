class Views::Admin::Users::User < Erector::RailsWidget
  needs :f
  
  def content
    div do
      text "e-mail"
      rawtext f.text_field :email 
    end
    div do
      text "login"
      rawtext f.text_field :login
    end
    div do
      text "password"
      rawtext f.text_field :password
    end
    div do
      text "password"
      rawtext f.text_field :password_confirmation
    end
  end
  
end