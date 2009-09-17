class Views::Admin::Users::User < Erector::RailsWidget
  needs :f
  
  def content
    div :class => 'field' do
      label 'Role'
      f.fields_for "user_role_attributes", f.object.user_role do |role_form|
            rawtext role_form.hidden_field :id unless role_form.id.nil?            
            rawtext role_form.collection_select 'role_id', Role.all, :id, :name
      end
    end
    
    
    div :class => 'field' do
      label "E-mail"
      rawtext f.text_field :email 
    end
    div :class => 'field' do
      label "Login"
      if f.object.id == current_user.id
        rawtext f.object.login
      else
        rawtext f.text_field :login
      end
    end

    if current_user.roles.first.name == 'admin' and action_name == 'new'
      div :class => 'field' do
        label "Password:"
        rawtext f.password_field :password
      end
      div :class => 'field' do
        label "Password confirmation:"
        if current_user.login == 'admin'
          rawtext f.password_field :password_confirmation
        else
          rawtext f.object.login
        end
      end
    end

  end
  
end
