class Views::Sessions::RecoverPassword < Erector::RailsWidget
  
  def content
   form_tag('/recover_password') do
      rawtext label { text "Email" }
      br
      rawtext text_field_tag('email')
      br
      rawtext submit_tag('Recover', ui_style(:button, :id => "main"))
    end
  end
  
end