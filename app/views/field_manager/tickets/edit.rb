class Views::FieldManager::Tickets::Edit < Views::Layouts::Application

  jquery "add_failure_dialog();"

  def page_title
    "Edit Ticket"
  end

  def view_content
    rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
    form_tag('/field_manager/tickets/update') do
      h2 do
        text 'Case details'
      end
      rawtext hidden_field_tag(:id, @ticket.id) 
      
      fieldset do
        div :class => 'field' do
          label "Product"
          rawtext simple_select :ticket, :product, :selected => @ticket.product_id
        end
        if current_user.has_role? :admin
          div :class => 'field' do
            label "Case ID"
            rawtext text_field_tag 'ticket[case_id]', @ticket.case_id
          end      
          div :class => 'field' do
            label "Opened at"
            rawtext datetime_select(:ticket, :opened_at)
          end     
        end
        div :class => 'field' do
          label "Region"
          rawtext filter_select :region, :customer_filter, :selected => @ticket.link
        end
        div :id => 'details' do
          widget Views::FieldManager::Tickets::EditDetails, :ticket => @ticket
        end
        if current_user.has_role? :admin
          div :class => 'field' do
            label "Updated/Closed at"
            rawtext datetime_select(:ticket, :updated_at)
          end      
        end
      end
      
      
      rawtext submit_tag 'Update', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)      
    end
  end
end
