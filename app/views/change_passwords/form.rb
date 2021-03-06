class Views::ChangePasswords::Form < Erector::RailsWidget

  def content
    form_for current_user, :url => { :action => 'update'}, :method => :put do |f|
      rawtext error_messages_for 'user', :class => 'ui-state-error ui-corner-all'
      div :class => 'field' do
        label "Password"
        rawtext f.password_field :password, :value => nil, :size => 20
      end
      div :class => 'field' do
        label "Password confirmation"
        rawtext f.password_field :password_confirmation, :size => 20
      end

      rawtext f.submit 'Change password', ui_style(:button)
      rawtext link_to('Back', {:controller => current_user.roles.first.name + '/tickets', :action => 'index'}, ui_style(:button))
    end
  end

end
