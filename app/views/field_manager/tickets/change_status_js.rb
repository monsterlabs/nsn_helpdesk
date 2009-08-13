class Views::FieldManager::Tickets::ChangeStatusJs < Views::Layouts::ApplicationJs
  def js_content
    text 'The ticket status has been changed...'
  end
end