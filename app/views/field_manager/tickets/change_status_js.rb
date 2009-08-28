class Views::FieldManager::Tickets::ChangeStatusJs < Views::Layouts::ApplicationJs
  def js_content
    dom_id = 'status_' + @ticket.dom_id 
    text "$('##{dom_id}').html('#{@ticket.status.name}');"
    if @ticket.status.id == 4
      dom_id = 'change_status_' + @ticket.dom_id + '_column'
      text "$('##{dom_id}').html('');"
    end
    text "$('##{@ticket.dom_id}').effect('highlight',{},4000);"
  end
end
