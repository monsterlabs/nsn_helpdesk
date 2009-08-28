class Views::Admin::Users::ShowJs < Views::Layouts::ApplicationJs
  # needs :value_tag_id, :associated_field_id, :user
  
  def js_content
    jquery %Q($("input##{@value_tag_id}").val("#{@user.id}");)
    
    p do
      b { text "Company"}
      text @user.person.company.name
    end
    p do
      b { text "Email"}
      text @user.email
    end
    p do
      b { text "Business phone"}
      text @user.address.business_phone
    end
    p do
      b { text "Home phone"}
      text @user.address.home_phone
    end
    p do
      b { text "Mobile phone"}
      text @user.address.mobile_phone
    end
    
    a :onclick => %Q($('input##{@associated_field_id}').enable();
                   $('input##{@associated_field_id}').val('');
                   $('##{@value_tag_id}').val('');
                   $(this).parent().html('');),
      :class => 'ui-state-default ui-corner-all button' do
      text 'Change'
    end
    
    link_to_remote("Edit",  { :url => {:controller => 'users', :action => 'edit', :id => @user.id}, :method => :get,
               :with => "'region_id=' + $('#customer_filter_region_id').val() + '&associated_field_id=#{@associated_field_id}&value_tag_id=#{@value_tag_id}&response_id=#{@response_id}'",
               :update => {:success => "add_edit_dialog"}, 
               :success => "$('#add_edit_dialog').dialog({
                 bgiframe: true,
                 height: 280,
                 modal: true,
                 autoOpen: false,
                 draggable: false,
                 resizable: false
               }); 
               $('#add_edit_dialog').dialog('open');
               set_button_behaviour();"},
               ui_style(:button))
  end
end