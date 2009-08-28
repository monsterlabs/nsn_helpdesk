class Views::Admin::Users::EditJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext error_messages_for 'user', :class => 'ui-state-error ui-corner-all'
    form_remote_tag(:url => "/users/update", 
      :success => "$('#add_edit_dialog').dialog('close'); $('div##{@response_id}').html(request); set_button_behaviour();") do |f|
        # widget Views::Links::Form, :record => @link
        rawtext hidden_field_tag 'response_id', @response_id
        rawtext hidden_field_tag 'value_tag_id', @value_tag_id
        rawtext hidden_field_tag 'associated_field_id', @associated_field_id
        rawtext hidden_field_tag(:id, @user.id)
        rawtext hidden_field_tag('user[person_attributes][id]', @user.person.id) 
        rawtext hidden_field_tag('user[address_attributes][id]', @user.address.id) 
        # rawtext hidden_field_tag('user[person_attributes][user_id]', @user.id) 
        p do
          b { text "Company"}
          # text @user.person.company.name
          # rawtext collection_select :company_id, Company.all, :id, :name
          rawtext simple_select 'user[person_attributes]', :company, :selected => @user.person.company_id
        end
        p do
          b { text "Email"}
          # text @user.email
          rawtext text_field_tag("user[email]", @user.email, :size => 30)
        end
        p do
          b { text "Business phone"}
          # text @user.address.business_phone
          rawtext text_field_tag("user[address_attributes][business_phone]", @user.address.business_phone, :size => 30)
        end
        p do
          b { text "Home phone"}
          # text @user.address.home_phone
          rawtext text_field_tag("user[address_attributes][home_phone]", @user.address.home_phone, :size => 30)
        end
        p do
          b { text "Mobile phone"}
          # text @user.address.mobile_phone
          rawtext text_field_tag("user[address_attributes][mobile_phone]", @user.address.mobile_phone, :size => 30)
        end
        rawtext submit_tag 'Update', ui_style(:button)
        a(ui_style(:button).merge({:onclick =>"$('#add_edit_dialog').dialog('close');"})) {text "Cancel"}
    end
    # text "form"
  end
end