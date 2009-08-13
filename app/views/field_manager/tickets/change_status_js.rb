class Views::FieldManager::Tickets::ChangeStatusJs < Views::Layouts::ApplicationJs
  def js_content
    dom_id = 'status_' + @ticket.dom_id 
    text "$('##{dom_id}').replaceWith('#{@ticket.status.name}');"
  end
end