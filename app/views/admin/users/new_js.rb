class Views::Admin::Users::NewJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext error_messages_for 'user', :class => 'ui-state-error ui-corner-all'
    form_remote_tag(:url => "/users/create", 
    :success => "$('#person_lastname_firstname').val($('#user_person_attributes_firstname').val() + ' ' + $('#user_person_attributes_lastname').val() ); $('div#reporter_details').html(request); $('#add_edit_dialog').dialog('close');") do
      rawtext hidden_field_tag 'user[person_attributes][region_id]'
      p do
        label "E-mail"
        rawtext text_field_tag 'user[email]' 
      end
      p do
        label "Firstname"
        rawtext text_field_tag 'user[person_attributes][firstname]' 
      end
       p do
        label "Lastname"
        rawtext text_field_tag 'user[person_attributes][lastname]'
      end
      
      p do
        label "Company"
        rawtext collection_select 'user[person_attributes]', :company_id, Company.all, :id, :name
      end
      
      p do
        label "Location"
        rawtext text_area_tag 'user[address_attributes][location]'
      end

      p do
        label "State"
        rawtext collection_select 'user[address_attributes]', :state_id, State.all, :id, :name, {:prompt => true}
      end

      p do
        label "City"
        rawtext collection_select 'user[address_attributes]', :city_id, City.all, :id, :name, {:prompt => true}
      end

      p do
        label "Zipcode"
        rawtext text_field_tag 'user[address_attributes][zipcode]'
      end

      p do
        label "Bussiness phone"
        rawtext text_field_tag 'user[address_attributes][business_phone]'
      end

      p do
        label "Mobile phone"
        rawtext text_field_tag 'user[address_attributes][mobile_phone]'
      end
      rawtext submit_tag 'Create', ui_style(:button)
      a(ui_style(:button).merge({:onclick =>'$("#add_edit_dialog").dialog("close");'})) {text "Cancel"}
    end
  end
end