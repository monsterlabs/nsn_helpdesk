class Views::FieldManager::Tickets::ShowFieldManagers < Views::Layouts::Application
  def page_title
    "Assign ticket"
  end

  def view_content
    rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
    form_for(@ticket, :url => { :action => "assign_field_manager"}) do |f|
      h2 do
        text 'Assign ticket to Field Manager'
      end

      div :class => 'field_manager_row' do
        label b "Field Manager:"
        rawtext f.select :assigned_to_id, User.field_managers.collect { |record| [record.person.fullname, record.id ]}, {:prompt => '-- Select --'}
      end

      rawtext f.submit 'Assign', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)      
     end
  end
end
