class Views::FieldManager::Tickets::ChangeOpenStatus < Views::Layouts::Application
  def page_title
    "Change Ticket Status"
  end

  def view_content
    rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
    form_for(@ticket, :url => {:action => "assign_ticket", :id => @ticket.id}) do |f|
      h2 do
        text 'Assign ticket to Field Manager'
      end
      div :class => 'assign_attributes' do
        span :class => 'field_manager' do
          label b "Field Manager:"
          rawtext f.select :assigned_to_id, User.field_managers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}
        end

        span :class => 'ticket_type' do
          label b "Ticket Type:"
          rawtext f.select :ticket_type_id, TicketType.all.collect { |record| [record.name, record.id ]}, {:prompt => '-- Select --'}
        end
      end

      rawtext f.submit 'Assign', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)      
    end
  end
end
